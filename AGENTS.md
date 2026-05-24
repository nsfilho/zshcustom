# zshcustom — Agent Notes

## What This Repo Is
Personal dotfiles for shell (zsh), tmux, neovim (LazyVim), and starship prompt. No build system, no CI, no tests. Pure bash install scripts targeting Debian Linux and macOS.

## Directory Map
| Path | Purpose |
|---|---|
| `configure.sh` | Main bootstrap — links configs to `$HOME`, runs all install scripts |
| `install.sh` | Entry point — remote bootstrap that curls + sources `utils.sh` and `configure.sh` |
| `utils.sh` | Shared helpers: `checkOS`, `deleteAndLink`, `aptInstall`, `npmGlobalInstall`, `cloneOrPull`, etc. |
| `installs/` | Per-tool install scripts (`tmux.sh`, `neovim.sh`, `fzf.sh`, `starship.sh`, `zoxide.sh`, etc.) — all source `utils.sh` |
| `shell/zshrc` | Main zsh config — sources `shell/aliases`, OS-specific zshrc, starship, zoxide, fzf |
| `shell/aliases` | Shell aliases (git, docker, kubectl, general) |
| `shell/linux/zshrc` | Linux-specific extensions (kubeconfig, golang, neovim editor defaults) |
| `shell/macos/zshrc` | macOS-specific extensions (Android emulator, F-key git bindings, go, llvm, openjdk) |
| `shell/tmux-{ver}.conf` | Version-matched tmux configs (1.9 through 3.5a) |
| `shell/starship.toml` | Tokyo Night–themed starship prompt config |
| `lazyvim/` | Neovim config using LazyVim dist — symlinked as `~/.config/nvim` by `installs/neovim.sh` |
| `lazyvim/lua/plugins/` | Custom LazyVim plugin overrides |
| `lazyvim/lua/config/` | LazyVim config overrides (options, keymaps, autocmds) |
| `scripts/` | CLI wrappers: docker stack deploy/remove, typescript boilerplate, alacritty terminfo |

## Key Mechanics
- **`configure.sh` creates symlinks**: `shell/zshrc` → `~/.zshrc`, `starship.toml` → `~/.config/starship.toml`
- **`installs/neovim.sh` symlinks** `lazyvim/` → `~/.config/nvim`. Editing `~/.config/nvim/...` will modify this repo if the link is active.
- **Tmux version detection**: `installs/tmux.sh` runs `tmux -V`, extracts the version, and symlinks `shell/tmux-{VERSION}.conf` → `~/.tmux.conf`. Adding a new tmux config means creating `shell/tmux-{NEW_VERSION}.conf` in the same format as existing ones.
- **`shell/zshrc` source chain**: main → `shell/aliases` → OS-specific (`shell/linux/zshrc` or `shell/macos/zshrc`) → optional `~/.zshlocal`
- **Auto-tmux**: If `$HOME/.notmux` doesn't exist and not already in tmux, `shell/zshrc` starts `tmux new-session -A -s main`
- **`utils.sh` is the single source of truth** for install helper functions. All `installs/*.sh` scripts call `source "$HOME"/.zshcustoms/utils.sh` first.

## Avante (LLM/AI) — Remote LLM Access
- **`lazyvim/lua/plugins/avante.lua`** uses the Avante Neovim plugin (Cursor-like AI assistant)
- **Local machine**: LLM runs directly via vllm on `:8000` — no env vars needed
- **Remote SSH sessions**: LLM accessed via tunnel (`-L 20430:127.0.0.1:8000`)
- **Environment variables** (sent via SSH `SendEnv`/`AcceptEnv`):\n  | Var | Default | Remote value | Purpose |\n  | `NEOVIM_LLM_REMOTE` | unset | `1` | Gate — plugin only loads on remote |\n  | `NEOVIM_LLM_PORT` | `8000` | `20430` | Tunneled port |\n  | `NEOVIM_LLM_HOST` | `127.0.0.1` | (same) | LLM host |\n  | `NEOVIM_LLM_MODEL` | `qwen` | (same) | Model name |\n- **`~/.ssh/config`** has `SendEnv NEOVIM_LLM_*` on `Host *`\n- **Remote servers** all have `AcceptEnv NEOVIM_LLM_*` in `sshd_config`\n- **`~/.zshlocal`** uses `ssh-llm()` function — wraps all SSH with tunnel + env\n- Changing the LLM model? Update `NEOVIM_LLM_MODEL` in `~/.zshlocal` env + plugin defaults

## Git
- Remote: `git@github.com:nsfilho/zshcustom.git`
- `lazyvim/lazy-lock.json` is in `.gitignore` — never commit

## No Build / Test / Lint
This repo has no package manager, CI pipeline, or test suite. Changes are validated by sourcing or rebooting the shell.
