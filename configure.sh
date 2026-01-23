#!/bin/bash
#
# Arquivo com as principais diretivas de instalacao
#
if [ "x$UPDATE_LOG" = "x" ]; then
    source $HOME/.zshcustoms/utils.sh
fi

checkOS
echo "💻 Operational System: $myOS"
echo "📦 Checking basis OS packages..."

if [ "$myDistro" = "debian" ]; then
    packages="sudo bash net-tools htop iftop rsync mtr zsh tmux git wget curl lynx"
    packages="$packages build-essential cmake automake libtool pkg-config"
    packages="$packages dialog git telnet dnsutils gettext iputils-ping tcpdump"
    packages="$packages ripgrep fd-find ncdu"
    aptInstall "$packages"
fi

cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"

# Shell configurations
$HOME/.zshcustoms/installs/fzf.sh
$HOME/.zshcustoms/installs/starship.sh
$HOME/.zshcustoms/installs/zoxide.sh
$HOME/.zshcustoms/installs/nodejs.sh
deleteAndLink "$HOME/.zshcustoms/shell/zshrc" "$HOME/.zshrc"
deleteAndLink "$HOME/.zshcustoms/shell/starship.toml" "$HOME/.config/starship.toml"

# Apps setup
bash ~/.zshcustoms/installs/git.sh
bash ~/.zshcustoms/installs/rust.sh
bash ~/.zshcustoms/installs/bat.sh

$HOME/.zshcustoms/installs/tmux.sh
$HOME/.zshcustoms/installs/neovim.sh
