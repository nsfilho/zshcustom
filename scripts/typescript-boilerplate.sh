#!/bin/bash

function download() {
	nomeArquivo=$1
	GIST="https://gist.githubusercontent.com/nsfilho/aaaa7afeb3169a695efb3231c6d37c82/raw"
	if [ ! -f $nomeArquivo ]; then
		nomeDownload=$(echo $nomeArquivo | sed "s/\//_/")
		wget -O $nomeArquivo "$GIST/$nomeDownload"
	fi
}

download prepare.sh
chmod +x prepare.sh
./prepare.sh
