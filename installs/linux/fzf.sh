#!/bin/bash
source "$HOME"/.zshcustoms/utils.sh
checkOS

# clone
cloneOrPull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

# install
echo "Installing fzf..."
"$HOME"/.fzf/install --all --no-update-rc >>"$UPDATE_LOG"
