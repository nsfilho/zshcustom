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

# check if username is configured
if [ -z "$(git config --global user.name)" ]; then
    # use dialog to get the username and set the git config
    dialog --inputbox "Enter your name for git" 10 60 2>/tmp/inputbox.tmp
    git config --global user.name $(cat /tmp/inputbox.tmp)
    rm -f /tmp/inputbox.tmp
fi

# check if email is configured
if [ -z "$(git config --global user.email)" ]; then
    # use dialog to get the email and set the git config
    dialog --inputbox "Enter your email for git" 10 60 2>/tmp/inputbox.tmp
    git config --global user.email $(cat /tmp/inputbox.tmp)
    rm -f /tmp/inputbox.tmp
fi
