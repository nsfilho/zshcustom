#!/bin/bash
#
# Code piece to install neovim
#
if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
    NEOVIM_LOCAL="/usr/local/bin/nvim"

    echo -n "Checking neovim:"
    if [ "$myOS" = "aiolink" ] ; then
        if [ ! -x /usr/local/bin/nvim ] ; then
            echo "installing..."
            downloadExtract "https://github.com/neovim/neovim/archive/v0.4.3.tar.gz" "$HOME/dist/neovim-0.4.3"
            make all install >> $UPDATE_LOG
        else
            echo "already installed."
        fi
    else
        NEOVIM_LOCAL="/usr/local/nvim-linux64/bin/nvim"
        if [ ! -d /usr/local/nvim-linux64 ] ; then
            echo "installing..."
            downloadExtract "https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz" "/usr/local/nvim-linux64"
        else
            echo "already installed."
        fi
    fi # generic linux
fi


if [ "$myOS" = "macos" ] ; then

fi

mkdir -p ~/.config/nvim
if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ] ; then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
deleteAndLink "$HOME/.zshcustoms/general/init.vim" "$HOME/.config/nvim/init.vim"
deleteAndLink "$HOME/.zshcustoms/general/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
set shell=/bin/bash
$NEOVIM_LOCAL +PlugInstall +qall
	
