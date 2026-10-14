#!/bin/bash
#
# Biblioteca de funcoes e utilitarios
#
UPDATE_LOG="/tmp/zshcustoms_$(whoami)_$(date +%Y-%m-%d_%H%M%S).log"

function deleteAndLink() {
    orig=$1
    dest=$2
    echo -n "🔀 Linking file $orig -> $dest: "
    ln -sf "$orig" "$dest"
    echo "done."
}

function cloneOrPull() {
    url=$1
    dest=$2
    echo -n "📁 Checking git project [$dest]: "
    if [ -d "$dest" ]; then
        if [ -n "$(cd "$dest" && git status --porcelain 2>/dev/null)" ]; then
            echo "ABORT: working tree dirty — commit/stash antes (trabalho nao commitado seria descartado)"
            return 1
        fi
        echo "updating..."
        cd "$dest"
        git reset --hard >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
        git clean -fd >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
        git pull >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
    else
        echo "cloning..."
        git clone --depth 1 "$url" "$dest" >>$UPDATE_LOG 2>>$UPDATE_LOG
    fi
}

# Return variables: myOS, myArch, myDistro
function checkOS() {
    if [ "x$OSTYPE" = "x" ]; then
        export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
        myOS=$OSTYPE
    fi

    case "$OSTYPE" in
        linux*)
            myOS="linux"
            if [ -f /etc/debian_version ]; then
                myDistro="debian"
            fi
            ;;
        darwin*)
            myOS="macos"
            ;;
    esac
    myArch=$(arch)
    return 0
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

function aptInstall() {
    packages=$1
    echo -n "📦 Installing APT packages [$packages]: "
    SUDOPREFIX=""
    if [ -x /usr/bin/sudo ]; then
        SUDOPREFIX="/usr/bin/sudo"
    fi
    if [ "x$APT_UPDATED" = "x" ]; then
        $SUDOPREFIX apt-get update >>$UPDATE_LOG 2>>$UPDATE_LOG
        export APT_UPDATED=1
    fi
    $SUDOPREFIX apt-get install -y $packages >>$UPDATE_LOG 2>>$UPDATE_LOG
    echo "done!"
}

function brewUpdate() {
    packages=$1
    if [ "x$BREW_UPDATED" = "x" ]; then
        brew update >>$UPDATE_LOG 2>>$UPDATE_LOG
        export BREW_UPDATED=1
    fi
    for i in $packages; do
        echo -n "📦 Upgrading BREW package [$i]: "
        brew upgrade $i >>$UPDATE_LOG 2>>$UPDATE_LOG
        echo "done!"
    done
}

function brewInstall() {
    packages=$1
    if [ "x$BREW_UPDATED" = "x" ]; then
        brew update >>$UPDATE_LOG 2>>$UPDATE_LOG
        export BREW_UPDATED=1
    fi
    for i in $packages; do
        echo -n "📦 Installing BREW package [$i]: "
        brew install $i >>$UPDATE_LOG 2>>$UPDATE_LOG
        echo "done!"
    done
}
