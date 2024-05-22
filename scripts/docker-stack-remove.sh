#!/bin/bash
if [ ! -f docker-compose.yml ]; then
	echo O diretório atual não contém um projeto do swarm.
	echo Esta faltando o arquivo: docker-compose.yml
	echo
else
	PROJETO=${PWD##*/}
	echo Projeto: $PROJETO
	docker stack ps $PROJETO
	watch -n 1 docker stack rm $PROJETO
fi
