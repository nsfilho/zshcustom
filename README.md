# Shell Customizations

## Instalação e re-instalação

Facilitadores de shell universal e atalhos para automação de rotinas.

```sh
curl -o - https://raw.githubusercontent.com/nsfilho/zshcustom/master/install.sh \
    | /bin/bash -
```

## Alterações úteis

## Ativando sudo sem passwd

Utilize o comando `visudo` e altere as linhas:

```txt
%admin ALL=(ALL) NOPASSWD: ALL
```

### Alteração da shell do usuário

```sh
chsh -s /bin/zsh
```

## Evitar o TMUX no Linux

```sh
touch ~/.notmux
```

## Atalhos do Neovim

```txt
<leader> => ,
<CTRL>+h => Window left
<CTRL>+l => Window Right
<ALT>+h => Buffer Left
<ALT>+l => Buffer right
<CTRL>+n => Nerd Tree
<CTRL>+x => exit
,t => procura arquivos no diretorio atual
,j => procura pela palavra do cursor atual
```
