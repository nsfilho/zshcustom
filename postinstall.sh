#!/bin/bash
#
# Arquivo com as principais diretivas de instalacao
#

checkOS
echo "Operational System: $myOS"
echo "Checking basis OS packages..."

if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
	aptInstall "sudo bash net-tools htop iftop rsync mtr vbetool zsh tmux vim git neovim wget curl clang cmake libclang-dev llvm-dev llvm rapidjson-dev exuberant-ctags dialog git telnet build-essential cmake dnsutils openvpn gettext iptables iputils-ping zsh lynx mc mosquitto-clients python3 ruby tcpdump ruby-dev"
    aptInstall "ripgrep fd-find"
    if [ ! -f /usr/bin/node ] ; then
        # Install Node 14.x
        curl -sL https://deb.nodesource.com/setup_16.x | bash -
        apt-get install -y nodejs
    fi
fi

if [ "$myOS" = "macos" ] ; then
    brewInstall "terminal-notifier asciinema cmake tmux neovim llvm ripgrep exa bat wget ncdu fd"
    brewUpgrade "neovim"
fi

checkGemInstall "colorls artii lolcat mdless neovim"

isUpdate
cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"
finishUpdate

bash ~/.zshcustoms/configure.sh
