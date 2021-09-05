#!/bin/bash
#
# Code piece to install neovim
#
NEOVIM_LAST_VERSION="0.5.0"
NEOVIM_LOCAL="/usr/local/bin/nvim"
if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
    echo -n "Checking neovim: "
    if [ "$myOS" = "aiolink" ] ; then
        if [ ! -f $HOME/.neovim-$NEOVIM_LAST_VERSION ] ; then
            echo "installing..."
            # downloadExtract "https://github.com/neovim/neovim/archive/v0.4.3.tar.gz" "$HOME/dist/neovim-0.4.3"
            downloadExtract "https://github.com/neovim/neovim/archive/refs/tags/v0.5.0.tar.gz" "$HOME/dist/neovim-$NEOVIM_LAST_VERSION"
            make all install >> $UPDATE_LOG
            touch $HOME/.neovim-$NEOVIM_LAST_VERSION
        else
            echo "already installed."
        fi
    else
        NEOVIM_LOCAL="/usr/local/nvim-linux64/bin/nvim"
        if [ ! -f $HOME/.neovim-$NEOVIM_LAST_VERSION ] ; then
            rm -rf /usr/local/nvim-linux64
            echo "installing..."
            # downloadExtract "https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz" "/usr/local/nvim-linux64"
            downloadExtract "https://github.com/neovim/neovim/releases/download/v0.5.0/nvim-linux64.tar.gz" "/usr/local/nvim-linux64"
            touch $HOME/.neovim-$NEOVIM_LAST_VERSION
        else
            echo "already installed."
        fi
    fi # generic linux
fi

# Install python modules
aptInstall "python3-pip"
which pip
if [ $? -eq 0 ] ; then
    pip install neovim
fi

mkdir -p ~/.config/nvim
if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ] ; then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
deleteAndLink "$HOME/.zshcustoms/general/init.vim" "$HOME/.config/nvim/init.vim"
deleteAndLink "$HOME/.zshcustoms/general/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

set shell=/bin/bash
$NEOVIM_LOCAL +PlugClean! +qall
$NEOVIM_LOCAL +PlugUpgrade +qall
$NEOVIM_LOCAL +PlugInstall +qall
$NEOVIM_LOCAL +CocUpdateSync +qall
	
