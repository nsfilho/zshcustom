#!/bin/bash
#
# Piece of code for setup tmux
#
source $HOME/.zshcustoms/utils.sh
checkOS

if [ "$myOS" = "linux" ]; then
	echo -n "Checking TMUX version: "
	TMUX_VERSION=$(tmux -V | sed -nr 's/tmux (.*)/\1/p')
	echo "$TMUX_VERSION"
fi

if [ "$myOS" = "macos" ]; then
	echo -n "Checking TMUX version: "
	TMUX_VERSION=$(tmux -V | sed -nE 's/tmux (.*)/\1/p')
	echo "$TMUX_VERSION"
fi

deleteAndLink "$HOME/.zshcustoms/shell/tmux-$TMUX_VERSION.conf" "$HOME/.tmux.conf"

# Install TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	echo "Installing TPM..."
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	$HOME/.tmux/plugins/tpm/bin/install_plugins
fi
