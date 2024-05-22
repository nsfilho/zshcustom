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

if [ "$myOS" = "linux" ]; then
	if [ "$myDistro" = "debian" ]; then
		packages="sudo bash net-tools htop iftop rsync mtr zsh tmux git wget curl lynx mc"
		packages="$packages clang cmake libclang-dev llvm-dev llvm rapidjson-dev exuberant-ctags"
		packages="$packages build-essential cmake python3 ruby ruby-dev automake libtool libtool-bin pkg-config"
		packages="$packages dialog git telnet dnsutils openvpn gettext iptables iputils-ping tcpdump"
		packages="$packages ripgrep fd-find ncdu"
		aptInstall $packages
	fi
elif [ "$myOS" = "macos" ]; then
	brewInstall "terminal-notifier asciinema cmake tmux llvm ripgrep exa bat wget ncdu fd dialog"
fi

cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"

$HOME/.zshcustoms/installs/fzf.sh
$HOME/.zshcustoms/installs/starship.sh
$HOME/.zshcustoms/installs/zoxide.sh
$HOME/.zshcustoms/installs/nodejs.sh

deleteAndLink "$HOME/.zshcustoms/shell/zshrc" "$HOME/.zshrc"
deleteAndLink "$HOME/.zshcustoms/shell/starship.toml" "$HOME/.config/starship.toml"

# Configurando Git
gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
gitAlias "slog" "log --pretty=oneline --abbrev-commit"
gitAlias "ap" "add --patch"
git config --global pull.rebase false
git config --global push.followTags true
git config --global push.autoSetupRemote true

# check if username is configured
if [ -z "$(git config --global user.name)" ]; then
	# use dialog to get the username and set the git config
	dialog --inputbox "Enter your name for git" 10 60 2>/tmp/inputbox.tmp
	git config --global user.name $(cat /tmp/inputbox.tmp)
	rm -f /tmp/inputbox.tmp
fi

# check if email is configured
if [ -z "$(git config --global user.email)" ]; then
	# use dialog to get the email and set the git config
	dialog --inputbox "Enter your email for git" 10 60 2>/tmp/inputbox.tmp
	git config --global user.email $(cat /tmp/inputbox.tmp)
	rm -f /tmp/inputbox.tmp
fi

# Install rust language
if [ ! -f $HOME/.cargo/bin/cargo ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >/tmp/rust.sh
	chmod +x /tmp/rust.sh
	/tmp/rust.sh -y
	rm -f /tmp/rust.sh
else
	rustup update
fi

if [ ! -f $HOME/.cargo/bin/exa ]; then
	$HOME/.cargo/bin/cargo install exa
fi

if [ ! -f $HOME/.cargo/bin/bat ]; then
	$HOME/.cargo/bin/cargo install bat
fi

$HOME/.zshcustoms/installs/tmux.sh
$HOME/.zshcustoms/installs/neovim.sh
