#!/bin/bash
# Config do neovim: ~/.config/nvim -> lazyvim/ (cross-OS).
# O binário do neovim é instalado por installs/linux/neovim.sh (tarball)
# ou installs/macos/brew.sh (Homebrew).
source "$HOME"/.zshcustoms/utils.sh

# In past, nvim is a directory. This small block is for compatibility upgrade.
# O marker lazyvim/.zshcustom torna o passo idempotente: roda uma vez e,
# quando ~/.config/nvim já aponta para o repo, é ignorado.
if [ ! -f ~/.config/nvim/.zshcustom ]; then
    if [ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
        echo "📦 Preservando config nvim atual em ~/.config/nvim.bak-$(date +%s)"
        mv ~/.config/nvim ~/.config/nvim.bak-$(date +%s)
    fi
    rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
    if [ ! -d "$HOME"/.config ]; then
        mkdir -p "$HOME"/.config
    fi
    ln -s ~/.zshcustoms/lazyvim ~/.config/nvim
fi

# Sync dos plugins (LazyVim)
echo "📦 LazyVim sync (Lazy! sync)"
nvim --headless "+Lazy! sync" +qa >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
