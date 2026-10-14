#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS
set -o pipefail

if ! command -v starship >/dev/null 2>&1; then
    echo "Installing starship"
    curl -sS https://starship.rs/install.sh | sh -s -- -y >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
fi
