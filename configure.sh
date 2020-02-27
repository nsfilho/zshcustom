#!/bin/bash

source $HOME/.zshcustoms/utils.sh

echo -n "Checking oh-my-zsh: "
if [ ! -d $HOME/.oh-my-zsh ] ; then
    echo "installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "already installed."
fi

cloneOrPull "https://github.com/bhilburn/powerlevel9k.git" "$HOME/.oh-my-zsh/custom/themes/powerlevel9k"
cloneOrPull "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
cloneOrPull "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
cloneOrPull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

echo "Installing fzf..."
$HOME/.fzf/install --all

# Outra customizações

if [ -d $HOME/.zshcustoms ] ; then
	cd $HOME/.zshcustoms

    deleteIfExists "$HOME/.zshrc"
    deleteIfExists "$HOME/.vimrc"
	deleteAndLink "$HOME/.zshcustoms/general/e01aio.zsh-theme" "$HOME/.oh-my-zsh/themes/e01aio.zsh-theme"

	#
	# Personalizações por sistema operacional
	#
    checkOS
	if [ "$myOS" = "linux" ] || [ "$myOS" = "aiolink" ] ; then
        echo -n "Checking TMUX version: "
        TMUX_VERSION=`tmux -V | sed -nr 's/tmux (.*)/\1/p'`
        echo "$TMUX_VERSION"

        echo "Installing linux dependencies..."
        sudo apt-get install -y automake libtool libtool-bin

        NEOVIM_LOCAL="/usr/local/bin/nvim"
        echo -n "Checking neovim:"
        if [ "$myOS" = "aiolink" ] ; then
            if [ ! -x /usr/local/bin/nvim ] ; then
                echo "installing..."
                downloadExtract "https://github.com/neovim/neovim/archive/v0.4.3.tar.gz" "$HOME/dist/neovim-0.4.3"
                make all install
            else
                echo "already installed."
            fi
        else
            NEOVIM_LOCAL="/usr/local/nvim-linux64/bin/nvim"
            if [ ! -d /usr/local/nvim-linux64 ] ; then
                echo "installing..."
                downloadExtract "https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz" "/usr/local/nvim-linux64"
            else
                echo "already installed."
            fi
        fi # generic linux
	fi # end linux


    if [ "$myOS" = "macos" ] ; then
        echo -n "Checking TMUX version: "
        TMUX_VERSION=`tmux -V | sed -nE 's/tmux (.*)/\1/p'`
        echo "$TMUX_VERSION"

		mkdir -p $HOME/.zshcustoms/iterm2/
        cloneOrPull "https://github.com/MartinSeeler/iterm2-material-design.git" "$HOME/.zshcustoms/iterm2/material-design"
        echo "Installing customizations for MacOS..."
		npm install -g svg-term-cli
	fi

    deleteAndLink "$HOME/.zshcustoms/general/tmux-$TMUX_VERSION.conf" "$HOME/.tmux.conf"
	deleteAndLink "$HOME/.zshcustoms/general/zshrc" "$HOME/.zshrc"
	deleteAndLink "$HOME/.zshcustoms/general/vimrc" "$HOME/.vimrc"
    cloneOrPull "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"

	# Configurando NeoVim
    mkdir -p ~/.config/nvim
	if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ] ; then
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
    deleteAndLink "$HOME/.zshcustoms/general/init.vim" "$HOME/.config/nvim/init.vim"
	deleteAndLink "$HOME/.zshcustoms/general/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
	set shell=/bin/bash
    $NEOVIM_LOCAL +PlugInstall +qall
	vim +PluginInstall +qall

	# Configurando Go
	if [ -d /usr/local/go/bin ] ; then
		/usr/local/go/bin/go get -u github.com/jmhobbs/terminal-parrot
	fi

	# Configurando Git
    gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
	gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
	gitAlias "slog" "log --pretty=oneline --abbrev-commit"
	gitAlias "ap" "add --patch"

    echo "Installing Node.js packages..."
	sudo npm install -g git+https://github.com/nsfilho/clustercmd.git
	sudo npm install -g git+https://github.com/nsfilho/clusterfile.git
    sudo npm install -g prettier

    echo "Installing YouCompleteMe dependencies..."
	if [ -d  ~/.vim/bundle/YouCompleteMe ] ; then
		cd ~/.vim/bundle/YouCompleteMe
		./install.py --clang-completer --ts-completer
	fi
else
	echo "ZshCustoms is not installed yet!"
fi
