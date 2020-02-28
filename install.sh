#!/bin/bash
#
# Prepare your computer to receive the shell zsh with esteroids
# Author: Nelio Santos (nsfilho@icloud.com)
#

function downloadUtils()
{
    TEMPUTILS=`mktemp`
    echo "Downloading library to $TEMPUTILS"
    curl -s -o $TEMPUTILS https://raw.githubusercontent.com/nsfilho/zshcustom/master/utils.sh
    source $TEMPUTILS
    rm -f $TEMPUTILS
}

downloadUtils

checkOS
echo "Operational System: $myOS"
echo "Checking basis OS packages..."

if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
	aptInstall "bash zsh tmux vim git neovim wget curl"
fi

if [ "$myOS" = "macos" ] ; then
    brewInstall "terminal-notifier asciinema macvim cmake tmux neovim"
fi

checkGemInstall "colorls artii lolcat mdless"

isUpdate
cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"
finishUpdate

bash ~/.zshcustoms/configure.sh
