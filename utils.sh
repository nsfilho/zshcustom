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

# Atualiza um repo git: em trabalho sujo, faz stash -u antes (sem pop automatico)
# e avisa onde as alteracoes ficaram. So aborta se o proprio stash falhar.
function cloneOrPull() {
    url=$1
    dest=$2
    if [ -d "$dest" ]; then
        cd "$dest" || { echo "ABORT: nao consigo acessar $dest"; return 1; }
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            if git stash push -u -m "zupdate auto-stash $(date +%F_%R)" >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"; then
                echo "📁 Updating git project [$dest] — local changes stashed ('git stash list')"
            else
                echo "ABORT: nao consegui stashing as alteracoes locais — nada foi atualizado."
                return 1
            fi
        fi
        echo "updating..."
        git reset --hard >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
        git clean -fd >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
        git pull >>"$UPDATE_LOG" 2>>"$UPDATE_LOG"
    else
        echo "cloning..."
        git clone --depth 1 "$url" "$dest" >>$UPDATE_LOG 2>>$UPDATE_LOG
    fi
}

# Exige arquitetura suportada (x86_64 ou aarch64) e a imprime
function requireArch() {
    arch=$(uname -m)
    if [ "$arch" != "x86_64" ] && [ "$arch" != "aarch64" ]; then
        echo "❌ Unsupported architecture: $arch (expected x86_64 or aarch64)"
        return 1
    fi
    echo "$arch"
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
