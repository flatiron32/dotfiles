# Copilot Journal

## 2026-02-26 — Dotfiles cleanup and private/public separation

### Architecture: private submodule
- Public repo: `flatiron32/dotfiles` (remote: `git@github-personal:flatiron32/dotfiles.git`)
- Private work config: `jacob-tomaw_wwg/dotfiles-grainger` as submodule at `private/work/`
- Shell configs auto-source all files from `private/*/` — zshrc uses `(N)` glob qualifier to handle empty dirs silently
- SSH: personal GitHub uses `github-personal` host alias → `~/.ssh/id_rsa`; work uses `github.com` → `~/.ssh/id_rsa2048`

### What lives in private/work/grainger
- gdevtool-plugin-init
- SDKMAN
- Rancher Desktop PATH + DOCKER_HOST + TESTCONTAINERS env vars

### Key changes made
- Replaced NVM with fnm (massive shell startup speedup)
- Moved fpath before OMZ source to avoid double compinit
- Removed ~100 lines of OMZ template boilerplate
- Replaced all `/Users/xjxt218/` with `$HOME`
- Removed dead code: ShopRunner/GrubHub functions, NTFS helper, Dropbox refs, Java 8 path

### Conventions Jacob wants
- Conventional commits: `type(scope): description`
- Small focused commits, not batched

### Second pass cleanup (same session)
- Removed reattach-to-user-namespace (pre-2015 macOS clipboard workaround)
- Removed tmux-copycat (deprecated, native tmux handles it)
- Removed jenv from zshrc (SDKMAN handles Java at Grainger)
- Removed dead bashrc: REPODIR, bash-git-prompt, yo tabtab, Intel LDFLAGS/CPPFLAGS
- Removed dead aliases: repofresh, gboth, p4
- Removed unused OMZ plugins: aws, colorize, gitignore, httpie
- Replaced powerline (broken Python dep) with vim-airline

### Brewfile cleanup
- Removed `tap "grainger/gdev", "git@github.com:wwg-internal/homebrew-gdev.git"` from public Brewfile (was exposing private GitHub org URL)
- Removed nvm, jenv, dropbox, temurin@8 from Brewfile
- Moved `git config url.insteadOf` from script/setup to private/work/grainger
- Made git clones in script/setup idempotent
- Added `vim +PluginInstall +qall` to script/setup
- Plan for full Brewfile split documented at `docs/brewfile-separation-plan.md`

### Brewfile split — completed
- Public Brewfile now personal-only (no Grainger tools, no private tap URLs)
- `~/.dotfiles/private/work/Brewfile.work` holds all Grainger taps/brews/casks/vscode extensions
- `private/work/grainger` exports `WORK_CONTEXT=grainger`
- brew wrapper in zshrc is now surgical: appends/removes individual lines, routes to correct Brewfile based on WORK_CONTEXT
- Handles install, uninstall, tap, untap
- `private/work/setup` script created — runs `brew bundle --file=Brewfile.work` for new Grainger machine provisioning

### Things to watch
- `bashrc` private-sourcing loop uses old `ls | grep` style — works but not as clean as zshrc version
- `bash_profile` and `bashrc` are lightly maintained; Jacob uses zsh exclusively
- SSH config (`~/.ssh/config` with `github-personal` alias) is NOT in dotfiles — must be set up manually on new machine before private submodule will clone
