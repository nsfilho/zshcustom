#!/bin/bash

source $HOME/.zshcustoms/utils.sh

# Configurando Git
gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
gitAlias "slog" "log --pretty=oneline --abbrev-commit"
gitAlias "ap" "add --patch"
git config --global pull.rebase false
git config --global push.followTags true
git config --global push.autoSetupRemote true
git config --global init.defaultBranch main

# Define um git config --global se vazio, perguntando via dialog ou stdin
function gitEnsure() {
    key=$1
    prompt=$2
    [ -n "$(git config --global "$key")" ] && return 0
    if command -v dialog >/dev/null 2>&1; then
        reply=$(mktemp)
        dialog --inputbox "$prompt" 10 60 2>"$reply"
        [ -s "$reply" ] && git config --global "$key" "$(cat "$reply")"
        rm -f "$reply"
    else
        echo -n "$prompt: "
        read -r value
        git config --global "$key" "$value"
    fi
}

gitEnsure "user.name" "Enter your name for git"
gitEnsure "user.email" "Enter your email for git"
