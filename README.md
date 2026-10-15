# Shell Customizations

## Instalação e reinstalação

Facilitadores de shell universal e atalhos para automação de rotinas.

```sh
curl -o - https://raw.githubusercontent.com/nsfilho/zshcustom/master/install.sh | /bin/bash -
```

> O alias `zupdate` repete esse fluxo. Se houver alterações locais não
> commitadas no repo, elas são preservadas automaticamente com `git stash -u`
> antes da atualização — para recuperá-las: `git stash list` / `git stash pop`.

### Requisitos instalados pelo `zupdate`

- **Linux (Debian-based)** — pacotes via `apt` (`installs/linux/packages.sh`,
  incluindo `ncurses` para as terminfos) + binários oficiais por arquitetura
  (`x86_64`/`aarch64`): neovim, nodejs; `bat` via cargo; fzf, starship e
  zoxide via instaladores oficiais.
- **macOS** — tudo via Homebrew (`installs/macos/brew.sh`):
  `neovim bat node fzf starship zoxide kubernetes-cli python@3.10 ncurses`.
  Se `nvm` estiver presente, ele mantém precedência sobre o node do brew.
- **Cross-OS** — git config, rustup, config LazyVim (`~/.config/nvim` →
  `lazyvim/`, preservando qualquer config atual em `~/.config/nvim.bak-<ts>`)
  e as terminfos do Alacritty (instaladas em `~/.terminfo`, sem root).

> No macOS, `python@3.10` fica na frente do `python3` do `/usr/local/bin`
> (python.org), e o `kubectl` do Homebrew ganha do do Docker Desktop.

## Ativando sudo sem password

Utilize o comando `visudo` e altere as linhas:

```txt
%admin ALL=(ALL) NOPASSWD: ALL
```

### Alteração da shell do usuário

```sh
chsh -s /bin/zsh
```

## Teclas de função

- **F06** : git pull
- **F07** : git status
- **F08** : git add --patch
- **F09** : git commit
- **F10** : git push
- <CTRL+T>: Pesquisa por um arquivo
- <CTRL+R>: Visualiza o historico de comandos

> No macOS, as teclas F6–F10 exigem a tecla **Fn** (configuração padrão do
> sistema: "Teclas de função como teclas padrão").

## Editor padrão

`nvim` em todos os sistemas: `EDITOR`/`VISUAL` e os aliases `vi`/`vim`
(definidos em `shell/zshrc` quando o `nvim` está no PATH).

## Cores do `ls`

Alias `ls` por SO: `--color` (GNU/Linux) ou `-G` (macOS), cada um com o
esquema de cores default do próprio sistema. No macOS, o esquema pode ser
personalizado definindo `LSCOLORS` em `~/.zshlocal`.

## Atalhos do Neovim

Para facilitar a manutenção está sendo utilizada a distribuição: [Lazyvim](https://www.lazyvim.org/keymaps)
