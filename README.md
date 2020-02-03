# Instalação e re-instalação

Facilitadores de shell universal e atalhos para automação de rotinas.

```sh
curl -o - https://raw.githubusercontent.com/nsfilho/zshcustom/master/install.sh | /bin/sh -
```

# Alterações úteis

## Ativando sudo sem passwd

Utilize o comando `visudo` e altere as linhas:

```
%admin ALL=(ALL) NOPASSWD: ALL
```
