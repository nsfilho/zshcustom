#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

NODE_VERSION="v22.21.1"

if [ "$myOS" = "linux" ]; then
    arch=$(requireArch) || exit 1
    case "$arch" in
        x86_64)  NODE_TARBALL="node-${NODE_VERSION}-linux-x64.tar.xz" ;;
        aarch64) NODE_TARBALL="node-${NODE_VERSION}-linux-arm64.tar.xz" ;;
    esac
    NODE_DIR="/usr/local/$(basename "$NODE_TARBALL" .tar.xz)"
    if [ ! -d "$NODE_DIR" ]; then
        echo "Installing Node.js $NODE_VERSION"
        wget -O /tmp/nodejs.tar.xz "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL}"
        cd /usr/local && sudo tar xvf /tmp/nodejs.tar.xz
        sudo rm -f /usr/local/node
        sudo ln -s "$NODE_DIR" /usr/local/node
        rm -f /tmp/nodejs.tar.xz
    else
        echo "Node.js $NODE_VERSION already installed"
    fi
elif [ "$myOS" = "macos" ]; then
    brewInstall "node"
fi
