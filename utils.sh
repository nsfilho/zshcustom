#!/bin/bash
#
# Biblioteca de funcoes e utilitarios
#
UPDATE_MARK="/tmp/.zshcustoms_`whoami`"

function downloadExtract()
{
    url=$1
    dest=$2
    tempFile=`mktemp`
    echo "Downloading Url: $url"
    wget -O $tempFile $url
    mkdir -p $dest
    cd $dest
    echo "Extracting in $dest..."
    tar xzvf $tempFile --strip-components 1
    rm -f $tempFile
}

function deleteAndLink()
{
    orig=$1
    dest=$1
    deleteIfExists $dest
    echo -n "Linking file $orig -> $dest: "
    ln -sf $orig $dest
    echo "done."
}

function deleteIfExists()
{
    pathCheck=$1
    echo -n "Delete if exists [$1]: "
    if [ -e $pathCheck ] ; then
        echo "deleting..."
        rm -rf $pathCheck
    else
        echo "not exists..."
    fi
}

function cloneOrPull()
{
    url=$1
    dest=$2
    echo -n "Checking git project [$2]: "
    if [ -d $2 ] ; then
        echo "updating..."
        cd $2
        git pull
    else
        echo "cloning..."
        git clone $url $2
    fi
}

function isUpdate()
{
    echo -n "Checking if it is an update: "
    if [ -f  $UPDATE_MARK ] ; then
        echo "yes"
        return true
    else
        echo "no"
        if [ -d ~/.zshcustoms ] ; then
            rm -rf ~/.zshcustoms
        fi
        return false
    fi
}


function finishUpdate()
{
    rm -f $UPDATE_MARK
}

function checkOS()
{
    if [ "x$OSTYPE" = "x" ] ; then
        if [ -d /etc/aiolink ] ; then
            return "aiolink"
        else
            export OSTYPE=`uname`
            return $OSTYPE
        fi
    fi
    
    if [ "$OSTYPE" = "linux-gnu" ] || [ "$OSTYPE" = "linux" ] || [ "$OSTYPE" = "Linux" ] ; then
        return "linux"
    fi

    if [ "$OSTYPE" = "darwin17.0" ] || [ "$OSTYPE" = "darwin18.0" ] || [ "$OSTYPE" = "darwin19.0" ] || [ "$OSTYPE" = "darwin19" ] ; then
        return "macos"
    fi

}

function checkGemInstall()
{
    package=$1
    echo -n "Checking Ruby Package [$1]:"
    if [ -f /usr/bin/gem ] || [ -f /usr/local/bin/gem ] ; then
        if [ ! -f /usr/local/bin/$package ] ; then
            echo "installing..."
            sudo gem install $package
        else
            echo "already installed."
        fi
    else
        echo "no ruby installed."
    fi
}


function gitAlias()
{
    aliasToCheck=$1
    content=$2
    echo -n "Checking git alias [$aliasToCheck]: "
    if [ x"`git config --get alias.$aliasToCheck`" = x ] ; then
        echo "setting done!"
        git config --global alias.$aliasToCheck "$content"
    else
        echo "already configured."
    fi
}
