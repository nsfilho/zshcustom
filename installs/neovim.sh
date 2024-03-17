#!/bin/bash
#
# Code piece to install neovim
#
source $HOME/.zshcustoms/utils.sh
checkOS

NEOVIM_LAST_VERSION="0.9.5"

if [ "$myOS" = "linux" ] && [ ! -f $HOME/.neovim-$NEOVIM_LAST_VERSION ]; then
	echo -n "Checking neovim: installing..."
	sudo rm -rf /usr/local/nvim-linux64 >>$UPDATE_LOG 2>&1
	sudo rm -rf /usr/local/share/nvim/runtime
	if [ ! -d $HOME/.neovim-$NEOVIM_LAST_VERSION ]; then
		downloadExtract "https://github.com/neovim/neovim/archive/refs/tags/v$NEOVIM_LAST_VERSION.tar.gz" "$HOME/dist/neovim-$NEOVIM_LAST_VERSION"
	fi
	cd $HOME/dist/neovim-$NEOVIM_LAST_VERSION
	sudo CMAKE_BUILD_TYPE=RelWithDebInfo make all install
	touch $HOME/.neovim-$NEOVIM_LAST_VERSION
	cd $HOME
else
	echo "already installed."
fi

# Atribui a versão correta do neovim
NEOVIM_LOCAL="/usr/local/bin/nvim"

# Install python modules
aptInstall "python3-pip"
aptInstall "python3-venv"
aptInstall "python3-neovim"
aptInstall "python3-pynvim"
aptInstall "npm"
aptInstall "luarocks"

npmGlobalInstall "neovim"

# In past, nvim is a directory. This small block is for compatibility upgrade
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

if [ ! -d $HOME/.config ]; then
	mkdir -p $HOME/.config
fi

git clone https://github.com/LazyVim/starter ~/.config/nvim

set shell=/bin/bash
$NEOVIM_LOCAL --headless "+Lazy! sync" +qa
