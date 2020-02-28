#!/bin/bash
#
# Piece of code to setup vim
#

deleteAndLink "$HOME/.zshcustoms/general/vimrc" "$HOME/.vimrc"
cloneOrPull "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"

set shell=/bin/bash
vim +PluginInstall +qall

echo "Installing YouCompleteMe dependencies..."
if [ -d  ~/.vim/bundle/YouCompleteMe ] ; then
	cd ~/.vim/bundle/YouCompleteMe
	./install.py --clang-completer --ts-completer >> $UPDATE_LOG
fi
