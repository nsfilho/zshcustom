#!/bin/bash

# Install rust language
if [ ! -f $HOME/.cargo/bin/cargo ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >/tmp/rust.sh
    chmod +x /tmp/rust.sh
    /tmp/rust.sh -y
    rm -f /tmp/rust.sh
else
    rustup update
fi
