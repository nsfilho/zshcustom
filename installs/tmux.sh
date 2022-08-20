#!/bin/bash
#
# Piece of code for setup tmux
#
if [ "$myOS" = "linux" ] ; then
    echo -n "Checking TMUX version: "
    TMUX_VERSION=`tmux -V | sed -nr 's/tmux (.*)/\1/p'`
    echo "$TMUX_VERSION"
fi 

if [ "$myOS" = "macos" ] ; then
    echo -n "Checking TMUX version: "
    TMUX_VERSION=`tmux -V | sed -nE 's/tmux (.*)/\1/p'`
    echo "$TMUX_VERSION"
fi

deleteAndLink "$HOME/.zshcustoms/general/tmux-$TMUX_VERSION.conf" "$HOME/.tmux.conf"
