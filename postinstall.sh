#!/bin/bash
#
# Arquivo com as principais diretivas de instalacao
#

checkOS
echo "Operational System: $myOS"
echo "Checking basis OS packages..."

if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
	aptInstall "sudo bash htop zsh tmux vim git neovim wget curl clang cmake libclang-dev llvm-dev llvm rapidjson-dev exuberant-ctags"
fi

if [ "$myOS" = "macos" ] ; then
    brewInstall "terminal-notifier asciinema macvim cmake tmux neovim llvm"
fi

checkGemInstall "colorls artii lolcat mdless"

isUpdate
cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"
finishUpdate

bash ~/.zshcustoms/configure.sh
