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
    packages="$packages dialog telnet dnsutils gettext iputils-ping tcpdump"
    packages="$packages ripgrep fd-find ncdu"
    aptInstall "$packages"
fi

cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"

# Executor de installs: uma falha avisa e nao interrompe o fluxo
run_install() {
    if ! bash "$HOME/.zshcustoms/installs/$1"; then
        echo "⚠️  Instalação de [$1] falhou — continuando."
    fi
}

# Shell configurations
run_install fzf.sh
run_install starship.sh
run_install zoxide.sh
run_install nodejs.sh
deleteAndLink "$HOME/.zshcustoms/shell/zshrc" "$HOME/.zshrc"
deleteAndLink "$HOME/.zshcustoms/shell/starship.toml" "$HOME/.config/starship.toml"

# Apps setup
run_install git.sh
run_install rust.sh
run_install bat.sh
run_install neovim.sh
