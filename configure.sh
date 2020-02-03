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

	# Configura o tmux
	if [ -f ~/.tmux.conf ] ; then
		rm -f ~/.tmux.conf
	fi
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
		echo "Personalizações para AIO-Links..."
		ln -s ~/.zshcustoms/aiolink/tmux.conf ~/.tmux.conf
	fi

	if [ "$OSTYPE" = "linux-gnu" ] ; then
		echo "Personalizações para servidores linux..."
		ln -s ~/.zshcustoms/linux/tmux.conf ~/.tmux.conf
	fi

	if [ "$OSTYPE" = "darwin17.0" -o  "$OSTYPE" = "darwin18.0" ] ; then
	    echo "Personalizações para estação de trabalho MacOS..."
		ln -s ~/.zshcustoms/linux/tmux.conf ~/.tmux.conf
		brew install terminal-notifier
	fi

	#
	# Instalações gerais, independente de sistema operacional
	#

	ln -f -s ~/.zshcustoms/general/vimrc ~/.vimrc
	ln -f -s ~/.zshcustoms/general/zshrc ~/.zshrc

	if [ -d ~/.vim/bundle/Vundle.vim ] ; then
		echo "VIM Bundle ja esta instalado..."
	else
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi

	set shell=/bin/bash
	vim +PluginInstall +qall

	#cd ~/.vim/bundle/tern_for_vim
	#npm install
	#ln -f -s ~/.zshcustoms/general/tern-project ~/.tern-project

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

	npm install -g git+https://github.com/nsfilho/clustercmd.git
	npm install -g git+https://github.com/nsfilho/clusterfile.git

else
	echo "Precisa ser feita a instalação!"

fi
