#!/bin/bash

# Install rust language
if [ ! -f $HOME/.cargo/bin/cargo ]; then
    if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >/tmp/rust.sh; then
        echo "❌ Failed to download rustup installer"
        exit 1
    fi
    chmod +x /tmp/rust.sh
    if ! /tmp/rust.sh -y; then
        echo "❌ rustup installation failed"
        rm -f /tmp/rust.sh
        exit 1
    fi
    rm -f /tmp/rust.sh
else
    rustup update
fi
