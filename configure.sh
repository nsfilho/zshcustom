#!/bin/bash

source $HOME/.zshcustoms/utils.sh

cloneOrPull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

#
# Install shell decorators
#

# if [ -d $HOME/.oh-my-zsh ] ; then
#     echo "Removing oh-my-zsh..."
#     rm -rf $HOME/.oh-my-zsh $HOME/.p10k.zsh >> $UPDATE_LOG
# fi

if [ ! -d $HOME/.oh-my-zsh/ ] ; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
curl -sS https://starship.rs/install.sh | sh -s -- -y >> $UPDATE_LOG

echo "Installing fzf..."
$HOME/.fzf/install --all >> $UPDATE_LOG

# Outra customizações
if [ -d $HOME/.zshcustoms ] ; then
	cd $HOME/.zshcustoms

    checkOS
	if [ "$myOS" = "linux" ] ; then
        aptInstall "automake libtool libtool-bin"
    fi

	deleteAndLink "$HOME/.zshcustoms/general/zshrc" "$HOME/.zshrc"
	deleteAndLink "$HOME/.zshcustoms/general/starship.toml" "$HOME/.config/starship.toml"

	# Configurando Git
    gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
	gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
	gitAlias "slog" "log --pretty=oneline --abbrev-commit"
	gitAlias "ap" "add --patch"
    git config --global push.followTags true

    # Install rust language
    if [ ! -f $HOME/.cargo/bin/cargo ] ; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rust.sh
        chmod +x /tmp/rust.sh
        /tmp/rust.sh -y
        rm -f /tmp/rust.sh
    else
        rustup update
    fi

    # Install rust packages
    if [ ! -f $HOME/.cargo/bin/btm ] ; then
        $HOME/.cargo/bin/cargo install bottom
    fi

    if [ ! -f $HOME/.cargo/bin/gitui ] ; then
        $HOME/.cargo/bin/cargo install gitui
    fi

    if [ ! -f $HOME/.cargo/bin/exa ] ; then
        $HOME/.cargo/bin/cargo install exa
    fi

    if [ ! -f $HOME/.cargo/bin/bat ] ; then
        $HOME/.cargo/bin/cargo install bat 
    fi

    # if [ ! -f $HOME/.cargo/bin/z ] ; then
    #     $HOME/.cargo/bin/cargo install zoxide --locked
    # fi

    #
    # Dependencies for Neovim
    #
    npmGlobalRemove tree-sitter-cli
    if [ ! -f $HOME/.cargo/bin/treesitter ] ; then
        $HOME/.cargo/bin/cargo install tree-sitter-cli
    fi

    source $HOME/.zshcustoms/installs/tmux.sh
    source $HOME/.zshcustoms/installs/neovim.sh
else
	echo "ZshCustoms is not installed yet!"
fi
