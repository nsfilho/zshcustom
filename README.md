# Shell Customizations

## Instalação e reinstalação

Facilitadores de shell universal e atalhos para automação de rotinas.

```sh
curl -o - https://raw.githubusercontent.com/nsfilho/zshcustom/master/install.sh | /bin/bash -
```

## Alterações úteis

## Ativando sudo sem password

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
## Teclas de função
-   **F02** : nvim
-   **F06** : git pull
-   **F07** : git status
-   **F08** : git add --patch
-   **F09** : git commit
-   **F10** : git push
-   <CTRL+T>: Pesquisa por um arquivo
-   <CTRL+R>: Visualiza o historico de comandos

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
