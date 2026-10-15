#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS
set -o pipefail

echo "Installing zoxide"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
