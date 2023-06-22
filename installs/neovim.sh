#!/bin/bash
#
# Code piece to install neovim
#
source $HOME/.zshcustoms/utils.sh
NEOVIM_LAST_VERSION="0.9.1"

if [ "$myOS" = "linux" ] && [ ! -f $HOME/.neovim-$NEOVIM_LAST_VERSION ]; then
    echo -n "Checking neovim: installing..."
    rm -rf /usr/local/nvim-linux64/bin/nvim >> $UPDATE_LOG 2>&1
    if [ ! -d $HOME/.neovim-$NEOVIM_LAST_VERSION ]; then
        downloadExtract "https://github.com/neovim/neovim/archive/refs/tags/v$NEOVIM_LAST_VERSION.tar.gz" "$HOME/dist/neovim-$NEOVIM_LAST_VERSION"
    fi
    cd $HOME/dist/neovim-$NEOVIM_LAST_VERSION
    make all install
    touch $HOME/.neovim-$NEOVIM_LAST_VERSION
    cd $HOME
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


npmGlobalInstall "neovim"
npmGlobalInstall "eslint_d"
npmGlobalInstall "prettier"

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
$NEOVIM_LOCAL --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	
