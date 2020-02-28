#!/bin/bash
#
# Piece of code to setup vim
#

deleteAndLink "$HOME/.zshcustoms/general/vimrc" "$HOME/.vimrc"
cloneOrPull "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"

set shell=/bin/bash
vim +PluginInstall +qall

if [ -d  ~/.vim/bundle/YouCompleteMe ] ; then
    echo "Installing YouCompleteMe dependencies..."
	cd ~/.vim/bundle/YouCompleteMe
	./install.py --clang-completer --ts-completer >> $UPDATE_LOG
fi
