#!/bin/bash
# Requisitos do dotfiles no macOS — tudo via Homebrew.
# (bat, node, fzf, starship e zoxide também existem em installs/linux/
# para o caminho "a mão" do Linux; aqui a fonte única é o brew.)
source "$HOME"/.zshcustoms/utils.sh
checkOS

# Homebrew (Apple Silicon ou Intel) — explícito, sem depender do PATH
BREW_BIN="/opt/homebrew/bin/brew"
[ -x "$BREW_BIN" ] || BREW_BIN="/usr/local/bin/brew"
if [ ! -x "$BREW_BIN" ]; then
    echo "❌ Homebrew não encontrado (/opt/homebrew ou /usr/local) — instale antes: https://brew.sh"
    exit 1
fi
export PATH="$(dirname "$BREW_BIN"):$PATH"

# neovim   -> editor padrão (shell/zshrc)
# bat      -> cat padrão (shell/aliases)
# node     -> Node.js (nvm, quando presente, mantém precedência)
# fzf      -> ctrl-r/ctrl-t (shell/zshrc: eval fzf --zsh)
# starship -> prompt (shell/zshrc: eval starship init zsh)
# zoxide   -> cd inteligente (shell/zshrc: eval zoxide init zsh)
# kubernetes-cli -> kubectl do PATH (shell/aliases: completion)
# python@3.10 -> precedência do python3 (shell/macos/zshrc)
# ncurses  -> tic, compila as terminfos do alacritty (installs/shared/alacritty-terminfo.sh)
BREW_REQUIRES="neovim bat node fzf starship zoxide kubernetes-cli python@3.10 ncurses"
echo "📦 Requirements via Homebrew: $BREW_REQUIRES"
brewInstall "$BREW_REQUIRES"
