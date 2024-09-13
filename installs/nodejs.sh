#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

if [ "$myOS" = "linux" ]; then
    if [ "$myDistro" = "debian" ]; then
        sudo apt install nodejs
    fi
fi
