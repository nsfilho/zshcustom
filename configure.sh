#!/bin/sh

if [ ! -d ~/.oh-my-zsh ] ; then
    echo "Instalando o Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ] ; then
	cd ~/.oh-my-zsh/custom/themes/powerlevel9k
	git pull
else
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

#
# Configura alguns plugins de decoração
# 
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] ; then
	cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git pull
else
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] ; then
	cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git pull
else
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# Instalação fzf
if [ -d ~/.fzf ] ; then
	cd ~/.fzf
	git pull
	~/.fzf/install --all
else
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all
fi

# Outra customizações

if [ -d ~/.zshcustoms ] ; then
	cd ~/.zshcustoms

	# Configura terminal zsh
	if [ -f ~/.zshrc ] ; then
		rm -f ~/.zshrc
	fi
	if [ -f ~/.vimrc ] ; then
		rm -f ~/.vimrc
	fi

	#
	# Prepara o tema do shell (Antigo)
	#
	rm -f ~/.oh-my-zsh/themes/e01aio.zsh-theme
	ln -s ~/.zshcustoms/general/e01aio.zsh-theme ~/.oh-my-zsh/themes/e01aio.zsh-theme

	#
	# Personalizações por sistema operacional
	#
	if [ "$OSTYPE" = "linux-gnueabihf" ] ; then
        TMUX_VERSION=`tmux -V | sed -nr 's/tmux (.*)/\1/p'`
		echo "Personalizações para AIO-Links..."
        sudo apt-get install -y automake libtool libtool-bin
        if [ ! -x /usr/local/bin/nvim ] ; then
            mkdir -p ~/dist
            cd ~/dist
            wget -O ~/dist/neovim-0.4.3.tar.gz https://github.com/neovim/neovim/archive/v0.4.3.tar.gz
            tar xzvf ~/dist/neovim-0.4.3.tar.gz
            cd neovim-0.4.3
            make all
            make install
        fi
	fi

	if [ "$OSTYPE" = "linux-gnu" ] ; then
        TMUX_VERSION=`tmux -V | sed -nr 's/tmux (.*)/\1/p'`
		echo "Personalizações para servidores linux..."
        if [ ! -d /usr/local/nvim-linux64 ] ; then
            wget -O /tmp/neovim-0.4.3.tar.gz https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
            cd /usr/local
            tar -xzvf /tmp/neovim-0.4.3.tar.gz
            rm -f /tmp/neovim-0.4.3.tar.gz
        fi

	fi

	if [ "$OSTYPE" = "darwin17.0" -o  "$OSTYPE" = "darwin18.0" -o "$OSTYPE" = "darwin19.0" ] ; then
		if [ ! -d ~/.zshcustoms/iterm2/ ] ; then
			mkdir ~/.zshcustoms/iterm2/
		fi

		if [ ! -d ~/.zshcustoms/iterm2/material-design ] ; then
			git clone https://github.com/MartinSeeler/iterm2-material-design.git ~/.zshcustoms/iterm2/material-design
		fi

	    echo "Personalizações para estação de trabalho MacOS..."
		npm install -g svg-term-cli
        TMUX_VERSION=`tmux -V | sed -nE 's/tmux (.*)/\1/p'`
	fi

	# Configura o tmux
	rm -f ~/.tmux.conf
    ln -s ~/.zshcustoms/general/tmux-$TMUX_VERSION.conf ~/.tmux.conf

	#
	# Instalações gerais, independente de sistema operacional
	#
	ln -f -s ~/.zshcustoms/general/zshrc ~/.zshrc

	# Configurando Vim
	ln -f -s ~/.zshcustoms/general/vimrc ~/.vimrc
	if [ -d ~/.vim/bundle/Vundle.vim ] ; then
		echo "VIM Bundle ja esta instalado..."
	else
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi

	# Configurando NeoVim
	if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ] ; then
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	if [ ! -d ~/.config/nvim ] ; then
		mkdir -p ~/.config/nvim
	fi
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/coc-settings.json
	ln -s ~/.zshcustoms/general/init.vim ~/.config/nvim/init.vim
	ln -s ~/.zshcustoms/general/coc-settings.json ~/.config/nvim/coc-settings.json
    if [ -d /usr/local/nvim-linux64 ] ; then
        NEOVIM_LOCAL="/usr/local/nvim-linux64/bin/nvim"
    fi
    if [ -x /usr/local/bin/nvim ] ; then
        NEOVIM_LOCAL="/usr/local/bin/nvim"
    fi
    $NEOVIM_LOCAL +PlugInstall +qall

	# Configurando Go
	if [ -d /usr/local/go/bin ] ; then
		/usr/local/go/bin/go get -u github.com/jmhobbs/terminal-parrot
	fi

	set shell=/bin/bash
	vim +PluginInstall +qall

	# Configurando Git
	gitlg=`git config --get alias.lg`
	if [ x"$gitlg" = x ] ; then
		git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
	fi

	gitapplyignore=`git config --get alias.apply-gitignore`
	if [ x"$gitapplyignore" = x ] ; then
		git config --global alias.apply-gitignore '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
	fi

	gitlogsingle=`git config --get alias.slog`
	if [ x"$gitlogsingle" = x ] ; then
		git config --global alias.slog "log --pretty=oneline --abbrev-commit"
	fi

	gitaddpath=`git config --get alias.ap`
	if [ x"$gitaddpath" = x ] ; then
		git config --global alias.ap "add --patch"
	fi

	sudo npm install -g git+https://github.com/nsfilho/clustercmd.git
	sudo npm install -g git+https://github.com/nsfilho/clusterfile.git
    sudo npm install -g prettier

	if [ -d  ~/.vim/bundle/YouCompleteMe ] ; then
		cd ~/.vim/bundle/YouCompleteMe
		./install.py --clang-completer --ts-completer
	fi


else
	echo "Precisa ser feita a instalação!"

fi
