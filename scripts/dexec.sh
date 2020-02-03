#!/bin/bash
#
# Autor: Nelio Souza Santos Filho
# Data : 2018-06-01
#

if [ "x$1" != "x" ] ; then
    filtro="--filter name=$1"
fi

LISTA=$(docker ps $filtro --no-trunc --format '{{.Names}}')
CONTAINERS=$(
    while read container ; do
        shortname=$(echo $container | cut -d '.' -f 1 )
        echo "$container" "$shortname"
    done <<< "${LISTA}"
)


# open fd
exec 3>&1

RESPOSTA=$(
dialog                              \
   --no-tags                        \
   --title 'Docker Shell'           \
   --menu 'Escolha o container:'    \
   0 0 0                            \
   $CONTAINERS                      \
2>&1 1>&3)

RESULTADO=$?

# close fd
exec 3>&-

if [ $RESULTADO -eq 0 ] ; then
    # open fd
    exec 3>&1

    CMDSHELL=$(
        dialog                                  \
            --title "Shell para execução"       \
            --menu "Shell"                      \
            0 0 0                               \
            "bash"  "/bin/bash"                 \
            "sh"    "/bin/sh"                   \
            "zsh"   "/usr/bin/zsh"              \
            "outros" "customizado"              \
        2>&1 1>&3)
    RESULTADO=$?

    # close fd
    exec 3>&-

    case "$CMDSHELL" in
        bash)
            CMD="/bin/bash"
            ;;
        sh)
            CMD="/bin/sh"
            ;;
        zsh)
            CMD="/usr/bin/zsh"
            ;;
        outros)
            # open fd
            exec 3>&1

            CMD=$(
                dialog                              \
                    --title "Shell para execução"   \
                    --inputbox "Comando:" 0 0       \
                2>&1 1>&3)
            if [ $RESULTADO -ne 0 ] ; then
                exit 0;
            fi
            
            # close fd
            exec 3>&-
            ;;
    esac

    echo -e "\n\n\ndocker exec -it $RESPOSTA $CMD"
    docker exec -it $RESPOSTA $CMD
fi
