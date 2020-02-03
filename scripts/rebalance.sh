#!/bin/sh

lista=`docker service ls --format '{{.Name}}'`
for i in $lista ; do
    echo "Rebalancing: $i"
    docker service update --force "$i"
done
