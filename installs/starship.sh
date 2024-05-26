#!/bin/bash
source $HOME/.zshcustoms/utils.sh
checkOS

if [ ! -f /usr/local/bin/starship ]; then
	curl -sS https://starship.rs/install.sh | sh -s -- -y >>$UPDATE_LOG
fi
