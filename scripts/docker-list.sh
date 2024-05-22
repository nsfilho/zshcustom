#!/bin/bash
#
# Autor: Nelio Santos (nelio@e01aio.com.br)
# Data : 2018-06-01
#

while : ; do

    STACKS=$(docker stack ls --format "{{.Name}}")
    CONTEUDO=$(
        while read v ; do
            echo "$v" "$v"
        done <<< "${STACKS}"
    )

    # open fd
    exec 3>&1

    SELECT=$(
        dialog                       \
            --no-tags                \
            --title "Stacks"         \
            --menu "Selecionar"      \
            0 0 0                    \
            $CONTEUDO                \
    2>&1 1>&3)

    RESULTADO=$?

    # close fd
    exec 3>&-

    if [ $RESULTADO -eq 0 ] ; then

        CONTAINERS=$(docker stack ps $SELECT --format "{{.ID}} {{.Node}} {{.Image}} {{.Name}}")
        DETALHES=()
        while read -r v_id v_node v_image v_name ; do
            DETALHES+=("$v_name" "$v_node: $v_image")
        done <<< "${CONTAINERS}"            

        # open fd
        exec 3>&1

        CONT=$(
            dialog                       \
                --title "Containers"     \
                --menu "Selecionar"      \
                0 0 0                    \
                "${DETALHES[@]}"         \
            2>&1 1>&3)

        RESULTADO=$?

        # close fd
        exec 3>&-

        if [ $RESULTADO -eq 0 ] ; then
            TEMPFILE=$(tempfile)
            CONTNAME=$(echo $CONT | sed 's/\.[0-9]$//g')
            docker service inspect $CONTNAME --pretty > $TEMPFILE 2>&1 3>&1
            
            dialog                              \
                --title "Detalhes: $SELECT"     \
                --textbox $TEMPFILE             \
                0 0

            rm -f $TEMPFILE
        fi
    else
        exit 0
    fi
done