# Brewfile Public/Private Separation Plan

## Problem

`~/.homebrew-brewfile/Brewfile` is public (`flatiron32/homebrew-brewfile`) but contains
Grainger-specific tools and — critically — an internal private GitHub tap URL:

```
tap "grainger/gdev", "git@github.com:wwg-internal/homebrew-gdev.git"
```

This exposes an internal GitHub org URL publicly.

## Key Constraint: brew bundle dump

The brew wrapper in `zshrc` uses `brew bundle dump --force` which snapshots *everything
currently installed* into one file. There is no native way to dump "only personal tools"
vs "only work tools" — it's all-or-nothing.

## Approach: Two Brewfiles

Split into:
- `~/.homebrew-brewfile/Brewfile` — personal tools only (public repo, stays as-is)
- `~/.dotfiles/private/work/Brewfile.work` — Grainger tools (private submodule)

### How `brew bundle` works at setup time

Strap runs `brew bundle --global` which reads `~/.Brewfile` or `~/.homebrew-brewfile/Brewfile`.
After the base install, Grainger setup (in private/work/grainger) would run:

```sh
brew bundle --file="$HOME/.dotfiles/private/work/Brewfile.work"
```

### How the brew wrapper changes

Currently: dumps everything to one Brewfile.

New behavior: dump everything, then split the diff. OR simpler — stop using
`brew bundle dump` and instead update the Brewfile surgically (add/remove the
specific package line) rather than regenerating the whole file.

The surgical approach is better because:
- Preserves comments and ordering
- Lets personal vs work Brewfiles stay separate
- Works correctly even with both sets of tools installed simultaneously

### Surgical brew wrapper logic

On `brew install foo`:
- If `$WORK_CONTEXT` is set (sourced from private/work/grainger): append to `Brewfile.work`
- Otherwise: append to personal `Brewfile`

On `brew uninstall foo`:
- Remove the line from whichever file contains it

`$WORK_CONTEXT` would be exported by `private/work/grainger` (already sourced at shell start
when the submodule is present).

## Immediate Cleanup (do first, low risk)

These can be removed from the public Brewfile now regardless of the split:

- [ ] `tap "grainger/gdev", "git@github.com:wwg-internal/homebrew-gdev.git"` — private URL, must go
- [ ] `brew "grainger/gdev/gdev"` — depends on above tap
- [ ] `brew "nvm"` — replaced by fnm
- [ ] `brew "jenv"` — removed from zshrc, no longer used
- [ ] `cask "dropbox"` — switched to Google Drive
- [ ] `cask "temurin@8"` — Java 8, likely dead

## Full Split (do after immediate cleanup)

Move these to `Brewfile.work` in the private submodule:

**Taps:**
- `tap "grainger/gdev"` (private URL)
- `tap "quarkusio/tap"`
- `tap "int128/kubelogin"`
- `tap "snyk/tap"`

**Brews:**
- `gradle`, `gradle-completion`, `groovysdk`, `maven` — Java build stack
- `openjdk@17` — Java runtime
- `k9s`, `kubernetes-cli`, `kubectx` — k8s tools
- `snyk-cli` — security scanning
- `openvpn` — Grainger VPN
- `grainger/gdev/gdev`, `quarkusio/tap/quarkus`, `int128/kubelogin/kubelogin`
- `hashicorp/tap/vault` — Grainger secret management
- `buildpacks/tap/pack`, `buildpacks/tap` tap

**Casks:**
- `rancher` — Rancher Desktop (Docker at Grainger)
- `intellij-idea` — Java IDE
- `dbeaver-community` — database tool (Grainger DBs)

**VS Code extensions:** All Java/Quarkus extensions

## Files to Change

1. `~/.homebrew-brewfile/Brewfile` — remove Grainger items, keep personal
2. `~/.dotfiles/private/work/Brewfile.work` — new file in private submodule
3. `~/.dotfiles/link/zshrc` — update brew wrapper to be surgical and context-aware
4. `~/.dotfiles/private/work/grainger` — add `export WORK_CONTEXT=grainger` and
   `brew bundle --file=...Brewfile.work` for initial setup

## Open Questions

- Does `WORK_CONTEXT` feel right as the env var name for detecting work context?
- Should the brew wrapper prompt when it's ambiguous (work tools installed on personal context)?
- What about casks — are any of the "work" casks also useful personally?
