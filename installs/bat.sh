#!/bin/bash

if [ ! -x $HOME/.cargo/bin/bat ]; then
    $HOME/.cargo/bin/cargo install bat
fi
