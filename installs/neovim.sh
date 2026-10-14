#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

NEOVIM_LAST_VERSION="0.12.6"

if [ "$myOS" = "linux" ]; then
    if [ "$myDistro" = "debian" ]; then
        aptInstall "python3-pip python3-venv"
    fi
    # Binario oficial do neovim por arquitetura
    arch=$(requireArch) || exit 1
    case "$arch" in
        x86_64)  NEOVIM_TARBALL="nvim-linux-x86_64.tar.gz" ;;
        aarch64) NEOVIM_TARBALL="nvim-linux-arm64.tar.gz" ;;
    esac
    if [ ! -f "$HOME"/.neovim-$NEOVIM_LAST_VERSION ]; then
        echo -n "Checking neovim: installing..."
        # Limpa instalacao anterior (build de fonte ou tarball legado)
        sudo rm -rf /usr/local/bin/nvim /usr/local/lib/nvim /usr/local/share/nvim /usr/local/nvim-linux64
        wget -O /tmp/$NEOVIM_TARBALL "https://github.com/neovim/neovim/releases/download/v$NEOVIM_LAST_VERSION/$NEOVIM_TARBALL" >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
        sudo tar xzf /tmp/$NEOVIM_TARBALL -C /usr/local --strip-components=1 >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
        rm -f /tmp/$NEOVIM_TARBALL
        touch "$HOME"/.neovim-$NEOVIM_LAST_VERSION
        echo "done."
    else
        echo "already installed."
    fi
    # Atribui a versão correta do neovim
    NEOVIM_LOCAL="/usr/local/bin/nvim"
elif [ "$myOS" = "macos" ]; then
    brewInstall "neovim"
    brewUpdate "neovim"
    NEOVIM_LOCAL="nvim"
fi

# In past, nvim is a directory. This small block is for compatibility upgrade
if [ ! -f ~/.config/nvim/.zshcustom ]; then
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
    ln -s ~/.zshcustoms/lazyvim ~/.config/nvim
fi

if [ ! -d "$HOME"/.config ]; then
    mkdir -p "$HOME"/.config
fi

$NEOVIM_LOCAL --headless "+Lazy! sync" +qa
