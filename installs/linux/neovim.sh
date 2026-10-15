#!/bin/bash
# Binario oficial do neovim no Linux, por arquitetura (x86_64 / aarch64).
# macOS usa Homebrew (installs/macos/brew.sh); o config (~/.config/nvim ->
# lazyvim/) e o Lazy! sync ficam em installs/shared/lazyvim.sh.
source "$HOME"/.zshcustoms/utils.sh
checkOS

NEOVIM_LAST_VERSION="0.12.6"

if [ "$myDistro" = "debian" ]; then
    aptInstall "python3-pip python3-venv"
fi

arch=$(requireArch) || exit 1
case "$arch" in
    x86_64)  NEOVIM_TARBALL="nvim-linux-x86_64.tar.gz" ;;
    aarch64) NEOVIM_TARBALL="nvim-linux-arm64.tar.gz" ;;
esac

if [ ! -f "$HOME"/.neovim-$NEOVIM_LAST_VERSION ]; then
    echo "Installing neovim $NEOVIM_LAST_VERSION"
    # Limpa instalacao anterior (build de fonte ou tarball legado)
    sudo rm -rf /usr/local/bin/nvim /usr/local/lib/nvim /usr/local/share/nvim /usr/local/nvim-linux64
    wget -O /tmp/$NEOVIM_TARBALL "https://github.com/neovim/neovim/releases/download/v$NEOVIM_LAST_VERSION/$NEOVIM_TARBALL" >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
    sudo tar xzf /tmp/$NEOVIM_TARBALL -C /usr/local --strip-components=1 >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
    rm -f /tmp/$NEOVIM_TARBALL
    touch "$HOME"/.neovim-$NEOVIM_LAST_VERSION
fi
