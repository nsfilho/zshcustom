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
    sudo apt-get update
	sudo apt-get -y install bash zsh tmux vim git neovim wget curl
fi

if [ "$myOS" = "macos" ] ; then
    brew install terminal-notifier
    brew install asciinema
    brew install macvim
    brew install cmake
    brew install tmux
fi

# For all operational systems
checkGemInstall colorls
checkGemInstall artii
checkGemInstall lolcat
checkGemInstall mdless

isUpdate
cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"

finishUpdate
bash ~/.zshcustoms/configure.sh
