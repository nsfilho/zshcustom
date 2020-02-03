#!/bin/sh

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
	apt-get -y install bash zsh tmux vim git
fi

if [ "$OSTYPE" = "linux-gnu" ] || [ "$OSTYPE" = "linux" ] || [ "$OSTYPE" = "Linux" ] ; then
	echo "Instalando pacotes adicionais para Servidores linux..."
	apt-get -y install bash zsh tmux vim git
	rm -f /bin/sh
	ln -s /bin/bash /bin/sh
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

if [ -d ~/.zshcustoms ] ; then
	cd ~/.zshcustoms
	git pull
else
	git clone https://github.com/nsfilho/zshcustom.git ~/.zshcustoms
fi

sh ~/.zshcustoms/configure.sh
