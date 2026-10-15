#!/bin/bash
# Instala as terminfos do Alacritty em ~/.terminfo (sem root) — cross-OS.
# Requer 'tic' (ncurses): Debian -> apt ncurses; macOS -> brew ncurses.
URL="https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info"

# Localiza o tic (PATH, Homebrew Apple Silicon ou Intel)
tic_bin=""
command -v tic >/dev/null 2>&1 && tic_bin="tic"
[ -z "$tic_bin" ] && [ -x /opt/homebrew/bin/tic ] && tic_bin="/opt/homebrew/bin/tic"
[ -z "$tic_bin" ] && [ -x /usr/local/bin/tic ] && tic_bin="/usr/local/bin/tic"
if [ -z "$tic_bin" ]; then
    echo "⚠️  'tic' não encontrado — terminfo do alacritty não instalada (Debian: apt install ncurses | macOS: brew install ncurses)."
    exit 1
fi

info=$(curl -sfL "$URL") || {
    echo "⚠️  Falha ao baixar o alacritty.info."
    exit 1
}

echo "↘️ Instalando terminfo do alacritty em ~/.terminfo"
mkdir -p "$HOME/.terminfo"
printf '%s\n' "$info" | "$tic_bin" -x -o "$HOME/.terminfo" - || {
    echo "⚠️  Falha na compilação do terminfo do alacritty."
    exit 1
}
