#!/bin/bash
if [ ! -f docker-compose.yml ]; then
	echo O diretório atual não contém um projeto do swarm.
	echo Esta faltando o arquivo: docker-compose.yml
	echo
else
	if [ -f prepare.sh ]; then
		echo "Executando script de preparação: prepare.sh"
		chmod +x prepare.sh
		bash prepare.sh
	fi

	PROJETO=${PWD##*/}
	echo Projeto: $PROJETO
	docker stack deploy --with-registry-auth -c docker-compose.yml $PROJETO
	watch -n 1 docker stack ps $PROJETO
fi
