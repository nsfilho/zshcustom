#!/bin/sh
UPDATE_MARK="/tmp/.zshcustoms_`whoami`"

echo "Detectando OSTYPE: [$OSTYPE]..."

if [ "x$OSTYPE" = "x" ] ; then
	if [ -d /etc/aiolink ] ; then
		export OSTYPE="linux-gnueabihf"
	else
		export OSTYPE=`uname`
	fi
	echo "Shell DASH Detectada, revisando OSTYPE: [$OSTYPE]..."
fi

if [ "$OSTYPE" = "linux-gnueabihf" ] ; then
	echo "Instalando pacotes adicionais para AIO-Link..."
	sudo apt-get -y install bash zsh tmux vim git neovim wget curl
fi

if [ "$OSTYPE" = "linux-gnu" ] || [ "$OSTYPE" = "linux" ] || [ "$OSTYPE" = "Linux" ] ; then
	echo "Instalando pacotes adicionais para Servidores linux..."
	sudo apt-get -y install bash zsh tmux vim git neovim wget curl
	# Evita nos debians a shell dash
	rm -f /bin/sh
	ln -s /bin/bash /bin/sh
fi


if [ "$OSTYPE" = "darwin17.0" -o  "$OSTYPE" = "darwin18.0" -o "$OSTYPE" = "darwin19.0" ] ; then
    echo "Personalizações para estação de trabalho MacOS..."
    brew install terminal-notifier
    brew install asciinema
    brew install macvim
    brew install cmake
    brew install tmux
fi

if [ -f /usr/bin/gem ] ; then
	if [ ! -f /usr/local/bin/colorls ] ; then
		sudo gem install colorls
	fi
	if [ ! -f /usr/local/bin/artii ] ; then
		sudo gem install artii
	fi
	if [ ! -f /usr/local/bin/lolcat ] ; then
		sudo gem install lolcat
	fi
	if [ ! -f /usr/local/bin/mdless ] ; then
		sudo gem install mdless
	fi
fi

# Se não for um update, elimina o diretorio
if [ ! -f $UPDATE_MARK ] ; then
	rm -rf ~/.zshcustoms
fi

if [ -d ~/.zshcustoms ] ; then
	cd ~/.zshcustoms
	git pull
else
	git clone https://github.com/nsfilho/zshcustom.git ~/.zshcustoms
fi

rm -f $UPDATE_MARK
sh ~/.zshcustoms/configure.sh
