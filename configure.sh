#!/bin/bash
source $HOME/.zshcustoms/utils.sh

#
# Fuzzy finder
#
cloneOrPull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

#
# Install shell decorators
#
if [ ! -d $HOME/.oh-my-zsh/ ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

cloneOrPull "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
cloneOrPull "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

#
# Starship customizations
#
if [ ! -f /usr/local/bin/starship ]; then
	curl -sS https://starship.rs/install.sh | sh -s -- -y >>$UPDATE_LOG
fi

echo "Installing fzf..."
$HOME/.fzf/install --all >>$UPDATE_LOG

# Outras customizações
if [ -d $HOME/.zshcustoms ]; then
	cd $HOME/.zshcustoms

	checkOS
	if [ "$myOS" = "linux" ]; then
		aptInstall "automake libtool libtool-bin pkg-config"
	fi

	deleteAndLink "$HOME/.zshcustoms/general/zshrc" "$HOME/.zshrc"
	deleteAndLink "$HOME/.zshcustoms/general/starship.toml" "$HOME/.config/starship.toml"

	# Configurando Git
	gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
	gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
	gitAlias "slog" "log --pretty=oneline --abbrev-commit"
	gitAlias "ap" "add --patch"

	git config --global pull.rebase false
	git config --global push.followTags true
	git config --global push.default simple

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

	# Install rust packages
	# if [ ! -f $HOME/.cargo/bin/btm ] ; then
	#     $HOME/.cargo/bin/cargo install bottom
	# fi

	# if [ ! -f $HOME/.cargo/bin/gitui ] ; then
	#     $HOME/.cargo/bin/cargo install gitui
	# fi

	if [ ! -f $HOME/.cargo/bin/exa ]; then
		$HOME/.cargo/bin/cargo install exa
	fi

	if [ ! -f $HOME/.cargo/bin/bat ]; then
		$HOME/.cargo/bin/cargo install bat
	fi

	# if [ ! -f $HOME/.cargo/bin/z ] ; then
	#     $HOME/.cargo/bin/cargo install zoxide --locked
	# fi

	#
	# Dependencies for Neovim
	#
	npmGlobalRemove tree-sitter-cli
	if [ ! -f $HOME/.cargo/bin/treesitter ]; then
		$HOME/.cargo/bin/cargo install tree-sitter-cli
	fi

	source $HOME/.zshcustoms/installs/tmux.sh
	source $HOME/.zshcustoms/installs/neovim.sh
else
	echo "ZshCustoms is not installed yet!"
fi
