#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

if [ "$myOS" = "linux" ]; then
    # https://nodejs.org/dist/v22.20.0/node-v22.20.0-linux-x64.tar.xz
    wget -O /tmp/nodejs.tar.xz https://nodejs.org/dist/v22.20.0/node-v22.20.0-linux-x64.tar.xz
    cd /usr/local && sudo tar xvf /tmp/nodejs.tar.xz
    sudo rm -f /usr/local/node
    sudo ln -s /usr/local/node-v22.20.0-linux-x64 /usr/local/node
    rm -f /tmp/nodejs.tar.xz
fi
