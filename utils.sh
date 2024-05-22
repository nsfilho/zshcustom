#!/bin/bash
#
# Biblioteca de funcoes e utilitarios
#
UPDATE_MARK="/tmp/.zshcustoms_$(whoami)"
UPDATE_LOG="/tmp/zshcustoms_$(whoami)_$(date +%Y-%m-%d_%H%M%S).log"

function downloadExtract() {
	url=$1
	dest=$2
	tempFile=$(mktemp)

	echo "↘️ Downloading Url: $url"
	wget -O $tempFile $url >>$UPDATE_LOG
	sudo mkdir -p $dest
	cd $dest
	echo "📁 Extracting in $dest..."
	sudo tar xzvf $tempFile --strip-components 1 >>$UPDATE_LOG
	rm -f $tempFile
}

function deleteAndLink() {
	orig=$1
	dest=$2
	deleteIfExists $dest
	echo -n "🔀 Linking file $orig -> $dest: "
	ln -sf $orig $dest
	echo "done."
}

function deleteIfExists() {
	pathCheck=$1
	echo -n "📁 Delete if exists [$1]: "
	if [ -e $pathCheck ]; then
		echo "deleting..."
		rm -rvf $pathCheck >>$UPDATE_LOG
	else
		echo "not exists..."
	fi
}

function cloneOrPull() {
	url=$1
	dest=$2
	echo -n "📁 Checking git project [$dest]: "
	if [ -d "$dest" ]; then
		echo "updating..."
		cd $dest
		git pull >>$UPDATE_LOG 2>>$UPDATE_LOG
	else
		echo "cloning..."
		git clone --depth 1 $url $dest >>$UPDATE_LOG 2>>$UPDATE_LOG
	fi
}

function isUpdate() {
	echo -n "✅Checking if it is an update: "
	if [ -f $UPDATE_MARK ]; then
		echo "yes"
		return 0
	else
		echo "no"
		if [ -d ~/.zshcustoms ]; then
			rm -rvf ~/.zshcustoms >>$UPDATE_LOG
		fi
		return 1
	fi
}

function finishUpdate() {
	rm -f $UPDATE_MARK
}

# Return variables: myOS, myArch, myDistro
function checkOS() {
	if [ "x$OSTYPE" = "x" ]; then
		export OSTYPE=$(uname)
		myOS=$OSTYPE
	fi

	if [ "$OSTYPE" = "linux-gnueabihf" ] || [ "$OSTYPE" = "linux-gnu" ] || [ "$OSTYPE" = "linux-android" ] || [ "$OSTYPE" = "linux" ] || [ "$OSTYPE" = "Linux" ]; then
		myOS="linux"
		if [ -f /etc/debian_version ]; then
			myDistro="debian"
		fi
	fi

	if [ "$OSTYPE" = "darwin17.0" ] || [ "$OSTYPE" = "darwin18.0" ] || [ "$OSTYPE" = "darwin19.0" ] || [ "$OSTYPE" = "darwin19" ] || [ "$OSTYPE" = "darwin21.0" ]; then
		myOS="macos"
	fi
	myArch=$(arch)
	return 0
}

function checkGemInstall() {
	packages=$1
	if [ -f /usr/bin/gem ] || [ -f /usr/local/bin/gem ]; then
		for package in $packages; do
			echo -n "📦 Checking Ruby Package [$package]:"
			if [ ! -f /usr/local/bin/$package ]; then
				echo "installing..."
				sudo gem install $package >>$UPDATE_LOG
			else
				echo "already installed."
			fi
		done
	else
		echo "📦 Checking Ruby Packages [$packages]: ❗no ruby installed."
	fi
}

function gitAlias() {
	aliasToCheck=$1
	content=$2
	echo -n "🔀 Checking git alias [$aliasToCheck]: "
	if [ x"$(git config --get alias.$aliasToCheck)" = x ]; then
		echo "setting done!"
		git config --global alias.$aliasToCheck "$content"
	else
		echo "already configured."
	fi
}

function npmGlobalInstall() {
	package=$1
	echo -n "📦 Installing NPM package [$package]: "
	npm install -g $package >>$UPDATE_LOG 2>>$UPDATE_LOG
	echo "done!"
}

function npmGlobalRemove() {
	package=$1
	echo -n "📦 Removing NPM package [$package]: "
	npm remove -g $package >>$UPDATE_LOG 2>>$UPDATE_LOG
	echo "done!"
}

function aptInstall() {
	packages=$1
	echo -n "📦 Installing APT packages [$packages]: "
	SUDOPREFIX=""
	if [ -x /usr/bin/sudo ]; then
		SUDOPREFIX="/usr/bin/sudo"
	fi
	$SUDOPREFIX apt-get update >>$UPDATE_LOG 2>>$UPDATE_LOG
	$SUDOPREFIX apt-get install -y $packages >>$UPDATE_LOG 2>>$UPDATE_LOG
	echo "done!"
}

function brewUpdate() {
	packages=$1
	brew update >>$UPDATE_LOG 2>>$UPDATE_LOG
	for i in $packages; do
		echo -n "📦 Upgrading BREW package [$i]: "
		brew upgrade $i >>$UPDATE_LOG 2>>$UPDATE_LOG
		echo "done!"
	done
}

function brewInstall() {
	packages=$1
	brew update >>$UPDATE_LOG 2>>$UPDATE_LOG
	for i in $packages; do
		echo -n "📦 Installing BREW package [$i]: "
		brew install $i >>$UPDATE_LOG 2>>$UPDATE_LOG
		echo "done!"
	done
}

echo "📓 Log file: $UPDATE_LOG"
