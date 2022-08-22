#!/bin/bash
#
# Code piece to install neovim
#
source $HOME/.zshcustoms/utils.sh
NEOVIM_LAST_VERSION="0.7.0"
NEOVIM_LOCAL="/usr/local/bin/nvim"

if [ "$myOS" = "linux" ] && [ ! -f $HOME/.neovim-$NEOVIM_LAST_VERSION ]; then
    echo -n "Checking neovim: "
    if [ "$myArch" = "aarch64" ] || [ "$myArch" = "armv7l" ] ; then
        echo "installing..."
        downloadExtract "https://github.com/neovim/neovim/archive/refs/tags/v0.7.0.tar.gz" "$HOME/dist/neovim-$NEOVIM_LAST_VERSION"
        make all install >> $UPDATE_LOG
        touch $HOME/.neovim-$NEOVIM_LAST_VERSION
    else
        NEOVIM_LOCAL="/usr/local/nvim-linux64/bin/nvim"
        rm -rf /usr/local/nvim-linux64
        echo "installing..."
        downloadExtract "https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.tar.gz" "/usr/local/nvim-linux64"
        touch $HOME/.neovim-$NEOVIM_LAST_VERSION
    fi # generic linux
else
    echo "already installed."
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

if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ] ; then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -d $HOME/.config ] ; then
    mkdir -p $HOME/.config
fi

deleteAndLink "$HOME/.zshcustoms/nvim" "$HOME/.config/nvim"

set shell=/bin/bash
$NEOVIM_LOCAL +PlugClean! +qall
$NEOVIM_LOCAL +PlugUpgrade +qall
$NEOVIM_LOCAL +PlugUpdate +qall
$NEOVIM_LOCAL +PlugInstall +qall
	
