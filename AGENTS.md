# zshcustom — Agent Notes

## What This Repo Is
Personal dotfiles for shell (zsh), neovim (LazyVim), and starship prompt. No build system, no CI, no tests. Pure bash install scripts targeting Debian Linux (x86_64 and aarch64) and macOS (Apple Silicon and Intel).

## Directory Map
| Path | Purpose |
|---|---|
| `configure.sh` | Main bootstrap — links configs to `$HOME`, runs install scripts per OS |
| `install.sh` | Entry point — remote bootstrap that curls + sources `utils.sh` and `configure.sh` |
| `utils.sh` | Shared helpers: `checkOS`, `deleteAndLink`, `aptInstall`, `brewInstall`, `cloneOrPull`, etc. |
| `installs/shared/` | Cross-OS installs: `git.sh`, `rust.sh`, `lazyvim.sh` (nvim config + sync), `alacritty-terminfo.sh` |
| `installs/linux/` | Linux (Debian) installs: `packages.sh` (apt base), `neovim.sh`/`nodejs.sh` (official tarballs per arch), `bat.sh` (cargo), `fzf.sh`, `starship.sh`, `zoxide.sh` |
| `installs/macos/` | macOS installs: `brew.sh` — single Homebrew requirements list |
| `shell/zshrc` | Main zsh config — brew/PATH per OS, editor nvim (all OS), ls color per OS, `shell/aliases`, OS-specific zshrc, starship, zoxide, fzf |
| `shell/aliases` | Shell aliases (git, docker, kubectl, general) — bat/kubectl detected via `command -v` |
| `shell/linux/zshrc` | Linux-specific extensions (kubeconfig, golang, log aliases) |
| `shell/macos/zshrc` | macOS-specific extensions (Android emulator, F-key git bindings, brew formula prefixes incl. python@3.10, go, llvm) |
| `shell/starship.toml` | Tokyo Night–themed starship prompt config |
| `lazyvim/` | Neovim config using LazyVim dist — symlinked as `~/.config/nvim` by `installs/shared/lazyvim.sh` |
| `lazyvim/lua/plugins/` | Custom LazyVim plugin overrides |
| `lazyvim/lua/config/` | LazyVim config overrides (options, keymaps, autocmds) |
| `scripts/` | CLI wrappers: docker stack deploy/remove, etc. |

## Key Mechanics
- **`configure.sh` creates symlinks**: `shell/zshrc` → `~/.zshrc`, `starship.toml` → `~/.config/starship.toml`
- **Per-OS install flow**: `configure.sh` runs `installs/<os>/*` by `myOS` (linux: apt + tarballs per arch; macos: `brew.sh`) then `installs/shared/*` (git, rust, lazyvim, alacritty terminfo). Arch variants live inside the linux scripts (`case` on `requireArch`: x86_64/aarch64 tarballs) — there are no per-arch copies of `shell/`.
- **`installs/shared/lazyvim.sh` symlinks** `lazyvim/` → `~/.config/nvim` (preserving any existing config in `~/.config/nvim.bak-<ts>`) and runs `Lazy! sync`. The `lazyvim/.zshcustom` marker makes the step idempotent. Editing `~/.config/nvim/...` will modify this repo if the link is active.
- **PATH order matters on macOS**: `shell/zshrc` evals `brew shellenv` before the base PATH, so `/opt/homebrew/bin` beats `/usr/local/bin` (brew kubectl over Docker Desktop's); `shell/macos/zshrc` then prepends `opt/python@3.10/bin` so brew's `python3` wins over `/usr/local/bin` (python.org).
- **`shell/zshrc` source chain**: main → `shell/aliases` → OS-specific (`shell/linux/zshrc` or `shell/macos/zshrc`) → optional `~/.zshlocal`
- **`utils.sh` is the single source of truth** for install helper functions. All `installs/*.sh` scripts call `source "$HOME"/.zshcustoms/utils.sh` first.
- **`cloneOrPull` handles dirty trees with auto-stash**: if the repo has local changes (incl. untracked), it runs `git stash push -u` before `reset --hard` + `clean -fd` + `pull`, and tells the user the changes live in `git stash list` (no auto-pop). It only aborts if the stash itself fails (or the target directory cannot be accessed).
- **`configure.sh` runs installs via `run_install`**: a failing install script prints a warning and the flow continues (failures are no longer silently swallowed).

## Avante (LLM/AI) — Remote LLM Access
- **`lazyvim/lua/plugins/avante.lua`** uses the Avante Neovim plugin (Cursor-like AI assistant)
- **Local machine**: LLM runs directly via vllm on `:8000` — no env vars needed
- **Remote SSH sessions**: LLM accessed via reverse tunnel (`-R 20430:127.0.0.1:8000`)
- **Environment variables** (sent via SSH `SendEnv`/`AcceptEnv`):\n  | Var | Default | Remote value | Purpose |\n  | `NEOVIM_LLM_REMOTE` | unset | `1` | Gate — plugin only loads on remote |\n  | `NEOVIM_LLM_PORT` | `8000` | `20430` | Tunneled port |\n  | `NEOVIM_LLM_HOST` | `127.0.0.1` | (same) | LLM host |\n  | `NEOVIM_LLM_MODEL` | `qwen` | (same) | Model name |\n- **`~/.ssh/config`** has `SendEnv NEOVIM_LLM_*` on `Host *`\n- **Remote servers** all have `AcceptEnv NEOVIM_LLM_*` in `sshd_config`\n- **`~/.zshlocal`** uses `ssh-llm()` function — wraps all SSH with tunnel + env\n- Changing the LLM model? Update `NEOVIM_LLM_MODEL` in `~/.zshlocal` env + plugin defaults

## Git
- Remote: `git@github.com:nsfilho/zshcustom.git`
- `lazyvim/lazy-lock.json` is in `.gitignore` — never commit

## No Build / Test / Lint
This repo has no package manager, CI pipeline, or test suite. Changes are validated by sourcing or rebooting the shell.
