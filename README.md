# Introdução

Facilitadores de shell universal e atalhos para automação de rotinas.

```sh
curl -o - https://github.com/nsfilho/zshcustom.git/raw/master/install.sh | /bin/sh -
```

# Alteração endereço da shell

Para corrigir o endereço do repositório:

```sh
cd ~/.zshcustoms
git remote -v
git remote set-url origin https://github.com/nsfilho/zshcustom.git
git remote -v
zupdate
```

# Alterações úteis

## Ativando sudo sem passwd

Utilize o comando `visudo` e altere as linhas:

```
%admin ALL=(ALL) NOPASSWD: ALL
```
