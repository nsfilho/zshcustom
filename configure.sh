#!/bin/bash
#
# Arquivo com as principais diretivas de instalacao
#
if [ "x$UPDATE_LOG" = "x" ]; then
    source $HOME/.zshcustoms/utils.sh
fi

checkOS
echo "💻 Operational System: $myOS (arch: $myArch)"

# Linux must be Debian-based
if [ "$myOS" = "linux" ] && [ ! -f /etc/debian_version ]; then
    echo "❌ Linux must be Debian-based (Debian/Raspberry Pi OS/Ubuntu)."
    echo "   Current system is not supported by this dotfiles."
    exit 1
fi

cloneOrPull "https://github.com/nsfilho/zshcustom.git" "$HOME/.zshcustoms"

# Executor de installs: uma falha avisa e nao interrompe o fluxo
run_install() {
    if ! bash "$HOME/.zshcustoms/installs/$1"; then
        echo "⚠️  Instalação de [$1] falhou (log: $UPDATE_LOG) — continuando."
    fi
}

# Configs de shell
deleteAndLink "$HOME/.zshcustoms/shell/zshrc" "$HOME/.zshrc"
deleteAndLink "$HOME/.zshcustoms/shell/starship.toml" "$HOME/.config/starship.toml"

# Requisitos por SO (installs/<os>/):
# linux  — pacotes apt + binarios oficiais por arquitetura (x86_64/aarch64)
# macos  — tudo via Homebrew
case "$myOS" in
    linux)
        if [ "$myDistro" = "debian" ] ; then
            run_install linux/packages.sh
        fi
        run_install linux/neovim.sh
        run_install linux/nodejs.sh
        run_install linux/bat.sh
        run_install linux/fzf.sh
        run_install linux/starship.sh
        run_install linux/zoxide.sh
        ;;
    macos)
        run_install macos/brew.sh
        ;;
esac

# Cross-OS
run_install shared/git.sh
run_install shared/rust.sh
run_install shared/lazyvim.sh
run_install shared/alacritty-terminfo.sh
