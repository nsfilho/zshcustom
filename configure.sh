#!/bin/bash
#
# Arquivo com as principais diretivas de instalacao
#
if [ "x$UPDATE_LOG" = "x" ]; then
    source $HOME/.zshcustoms/utils.sh
fi

checkOS
echo "💻 Operational System: $myOS (arch: $myArch)"

# Linux must be Debian-based
if [ "$myOS" = "linux" ] && [ ! -f /etc/debian_version ]; then
    echo "❌ Linux must be Debian-based (Debian/Raspberry Pi OS/Ubuntu)."
    echo "   Current system is not supported by this dotfiles."
    exit 1
fi

echo "📦 Checking basis OS packages..."

if [ "$myDistro" = "debian" ]; then
    packages="sudo bash net-tools htop iftop rsync mtr zsh git wget curl lynx"
    packages="$packages build-essential cmake automake libtool pkg-config"
    packages="$packages dialog git telnet dnsutils gettext iputils-ping tcpdump"
    packages="$packages ripgrep fd-find ncdu"
    aptInstall "$packages"
fi

cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"

# Shell configurations
bash "$HOME/.zshcustoms/installs/fzf.sh"
bash "$HOME/.zshcustoms/installs/starship.sh"
bash "$HOME/.zshcustoms/installs/zoxide.sh"
bash "$HOME/.zshcustoms/installs/nodejs.sh"
deleteAndLink "$HOME/.zshcustoms/shell/zshrc" "$HOME/.zshrc"
deleteAndLink "$HOME/.zshcustoms/shell/starship.toml" "$HOME/.config/starship.toml"

# Apps setup
bash ~/.zshcustoms/installs/git.sh
bash ~/.zshcustoms/installs/rust.sh
bash ~/.zshcustoms/installs/bat.sh

bash "$HOME/.zshcustoms/installs/neovim.sh"
