#!/bin/bash

source $HOME/.zshcustoms/utils.sh

echo -n "Checking oh-my-zsh: "
if [ ! -d $HOME/.oh-my-zsh ] ; then
    echo "installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "already installed."
fi

#cloneOrPull "https://github.com/bhilburn/powerlevel9k.git" "$HOME/.oh-my-zsh/custom/themes/powerlevel9k"
cloneOrPull "https://github.com/romkatv/powerlevel10k.git" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
cloneOrPull "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
cloneOrPull "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
cloneOrPull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

echo "Installing fzf..."
$HOME/.fzf/install --all >> $UPDATE_LOG

# Outra customizações

if [ -d $HOME/.zshcustoms ] ; then
	cd $HOME/.zshcustoms

    checkOS
	if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
        aptInstall "automake libtool libtool-bin"
    fi
    if [ "$myOS" = "macos" ] ; then
		mkdir -p $HOME/.zshcustoms/iterm2/
        cloneOrPull "https://github.com/MartinSeeler/iterm2-material-design.git" "$HOME/.zshcustoms/iterm2/material-design"
        cloneOrPull "https://github.com/dracula/iterm.git" "$HOME/.zshcustoms/iterm2/dracula"
        npmGlobalInstall "svg-term-cli"
	fi

	deleteAndLink "$HOME/.zshcustoms/general/zshrc" "$HOME/.zshrc"
	deleteAndLink "$HOME/.zshcustoms/general/e01aio.zsh-theme" "$HOME/.oh-my-zsh/themes/e01aio.zsh-theme"
	deleteAndLink "$HOME/.zshcustoms/themes/p10k.zsh" "$HOME/.p10k.zsh"

	# Configurando Go
	if [ -d /usr/local/go/bin ] ; then
		/usr/local/go/bin/go get -u github.com/jmhobbs/terminal-parrot
	fi

	# Configurando Git
    gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
	gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
	gitAlias "slog" "log --pretty=oneline --abbrev-commit"
	gitAlias "ap" "add --patch"
    git config --global push.followTags true
	npmGlobalInstall "git+https://github.com/nsfilho/clustercmd.git"
	npmGlobalInstall "git+https://github.com/nsfilho/clusterfile.git"
    npmGlobalInstall "git+https://github.com/nsfilho/traefikconfig.git"
    npmGlobalInstall "prettier"
    npmGlobalInstall "neovim"

    source $HOME/.zshcustoms/installs/tmux.sh
    # source $HOME/.zshcustoms/installs/vim.sh
    source $HOME/.zshcustoms/installs/neovim.sh
else
	echo "ZshCustoms is not installed yet!"
fi
