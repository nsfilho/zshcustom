#!/bin/bash

source "$HOME"/.zshcustoms/utils.sh

# Install rust language
if [ ! -f $HOME/.cargo/bin/cargo ]; then
    echo "Installing Rust (rustup)"
    if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >/tmp/rust.sh; then
        echo "❌ Failed to download rustup installer"
        rm -f /tmp/rust.sh
        exit 1
    fi
    chmod +x /tmp/rust.sh
    if ! /tmp/rust.sh -y >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"; then
        echo "❌ rustup installation failed"
        rm -f /tmp/rust.sh
        exit 1
    fi
    rm -f /tmp/rust.sh
else
    echo "Updating Rust (rustup)"
    "$HOME/.cargo/bin/rustup" update >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
fi
