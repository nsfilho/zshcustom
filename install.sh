#!/bin/bash
#
# Prepare your computer to receive the shell zsh with esteroids
# Author: Nelio Santos (nsfilho@icloud.com)
#
function downloadPart()
{
    partName=$1
    TEMPUTILS=`mktemp`
    echo "Downloading: $partName -> $TEMPUTILS"
    curl -s -o $TEMPUTILS "https://raw.githubusercontent.com/nsfilho/zshcustom/master/$partName"
    echo "Running: $partName"
    source $TEMPUTILS
    rm -f $TEMPUTILS
}

sudo echo "Starting support to elevate privileges..."
downloadPart "utils.sh"
downloadPart "postinstall.sh"

