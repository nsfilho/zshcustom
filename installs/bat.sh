#!/bin/bash

if [ ! -x $HOME/.cargo/bin/bat ]; then
    if [ ! -x $HOME/.cargo/bin/cargo ]; then
        echo "❌ cargo nao encontrado em $HOME/.cargo/bin/cargo — instale o Rust primeiro (installs/rust.sh)."
        exit 1
    fi
    $HOME/.cargo/bin/cargo install bat
fi
