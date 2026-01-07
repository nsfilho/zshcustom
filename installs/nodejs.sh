#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

arch=$(uname -m)

if [ "$myOS" = "linux" ]; then
    if [ "$arch" = "x86_64" ]; then
        if [ ! -d /usr/local/node-v22.20.0-linux-x64 ]; then
            echo "Installing Node.js v22.20.0"
            wget -O /tmp/nodejs.tar.xz https://nodejs.org/dist/v22.20.0/node-v22.20.0-linux-x64.tar.xz
            cd /usr/local && sudo tar xvf /tmp/nodejs.tar.xz
            sudo rm -f /usr/local/node
            sudo ln -s /usr/local/node-v22.20.0-linux-x64 /usr/local/node
            rm -f /tmp/nodejs.tar.xz
            export PATH="/usr/local/node/bin:$PATH"
        else
            echo "Node.js v22.20.0 already installed"
        fi
    elif [ "$arch" = "aarch64" ]; then
        if [ ! -d /usr/local/node-v22.21.1-linux-arm64 ]; then
            echo "Installing Node.js v22.21.1"
            wget -O /tmp/nodejs.tar.xz https://nodejs.org/dist/v22.21.1/node-v22.21.1-linux-arm64.tar.xz
            cd /usr/local && sudo tar xvf /tmp/nodejs.tar.xz
            sudo rm -f /usr/local/node
            sudo ln -s /usr/local/node-v22.21.1-linux-arm64 /usr/local/node
            rm -f /tmp/nodejs.tar.xz
            export PATH="/usr/local/node/bin:$PATH"
        else
            echo "Node.js v22.21.1 already installed"
        fi

    fi
fi
