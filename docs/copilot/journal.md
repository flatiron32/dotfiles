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

### Things to watch
- `bashrc` private-sourcing loop uses old `ls | grep` style — works but not as clean as zshrc version
- `bash_profile` and `bashrc` are lightly maintained; Jacob uses zsh exclusively
