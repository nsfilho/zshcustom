#!/bin/bash
#
# Code piece to install neovim
#
source $HOME/.zshcustoms/utils.sh
NEOVIM_LAST_VERSION="0.7.0"

if [ "$myOS" = "linux" ] && [ ! -f $HOME/.neovim-$NEOVIM_LAST_VERSION ]; then
    echo -n "Checking neovim: "
    if [ "$myArch" = "aarch64" ] || [ "$myArch" = "armv7l" ] ; then
        echo "installing..."
        downloadExtract "https://github.com/neovim/neovim/archive/refs/tags/v0.7.0.tar.gz" "$HOME/dist/neovim-$NEOVIM_LAST_VERSION"
        make all install >> $UPDATE_LOG
        touch $HOME/.neovim-$NEOVIM_LAST_VERSION
    else
        rm -rf /usr/local/nvim-linux64
        echo "installing..."
        downloadExtract "https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.tar.gz" "/usr/local/nvim-linux64"
        touch $HOME/.neovim-$NEOVIM_LAST_VERSION
    fi # generic linux
else
    echo "already installed."
fi

# Atribui a versão correta do neovim
NEOVIM_LOCAL="/usr/local/bin/nvim"
if [ -f /usr/local/nvim-linux64/bin/nvim ] ; then
    NEOVIM_LOCAL="/usr/local/nvim-linux64/bin/nvim"
fi

# Install python modules
aptInstall "python3-pip"
which pip
if [ $? -eq 0 ] ; then
    pip install neovim
    pip3 install pynvim
fi

# In past, nvim is a directory. This small block is for compatibility upgrade
if [ -d ~/.config/nvim ] ; then
    rm -rf ~/.config/nvim
fi

if [ ! -d $HOME/.config ] ; then
    mkdir -p $HOME/.config
fi

if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ] ; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi


deleteAndLink "$HOME/.zshcustoms/nvim" "$HOME/.config/nvim"

set shell=/bin/bash
$NEOVIM_LOCAL +PlugClean! +qall
$NEOVIM_LOCAL +PlugUpgrade +qall
$NEOVIM_LOCAL +PlugUpdate +qall
$NEOVIM_LOCAL +PlugInstall +qall
	
