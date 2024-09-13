#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

NEOVIM_LAST_VERSION="0.10.0"

if [ ! -f "$HOME"/.cargo/bin/treesitter ]; then
    "$HOME"/.cargo/bin/cargo install tree-sitter-cli
fi

if [ "$myOS" = "linux" ]; then
    if [ "$myDistro" = "debian" ]; then
        npmGlobalRemove tree-sitter-cli
        npmGlobalInstall "neovim"
        aptInstall "python3-pip python3-venv python3-neovim python3-pynvim npm luarocks"
    fi
    if [ ! -f "$HOME"/.neovim-$NEOVIM_LAST_VERSION ]; then
        echo -n "Checking neovim: installing..."
        sudo rm -rf /usr/local/nvim-linux64 >>"$UPDATE_LOG" 2>&1
        sudo rm -rf /usr/local/share/nvim/runtime
        if [ ! -d "$HOME"/.neovim-$NEOVIM_LAST_VERSION ]; then
            downloadExtract "https://github.com/neovim/neovim/archive/refs/tags/v$NEOVIM_LAST_VERSION.tar.gz" "$HOME/dist/neovim-$NEOVIM_LAST_VERSION"
        fi
        cd "$HOME"/dist/neovim-$NEOVIM_LAST_VERSION || exit
        sudo CMAKE_BUILD_TYPE=RelWithDebInfo make all install
        touch "$HOME"/.neovim-$NEOVIM_LAST_VERSION
        cd "$HOME" || exit
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
