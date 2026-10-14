#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y >>"$UPDATE_LOG"
fi
