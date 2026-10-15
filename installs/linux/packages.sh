#!/bin/bash
# Pacotes base do SO (Debian-based) — requisito do dotfiles.
source "$HOME"/.zshcustoms/utils.sh
checkOS

if [ "$myDistro" = "debian" ]; then
    packages="sudo bash net-tools htop iftop rsync mtr zsh git wget curl lynx"
    packages="$packages build-essential cmake automake libtool pkg-config"
    packages="$packages dialog telnet dnsutils gettext iputils-ping tcpdump"
    packages="$packages ripgrep fd-find ncdu ncurses"
    aptInstall "$packages"
fi
