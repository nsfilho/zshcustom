#!/bin/bash

source "$HOME"/.zshcustoms/utils.sh

if [ ! -x $HOME/.cargo/bin/bat ]; then
    if [ ! -x $HOME/.cargo/bin/cargo ]; then
        echo "❌ cargo nao encontrado em $HOME/.cargo/bin/cargo — instale o Rust primeiro (installs/rust.sh)."
        exit 1
    fi
    echo "Installing bat (cargo)"
    $HOME/.cargo/bin/cargo install bat >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
fi
