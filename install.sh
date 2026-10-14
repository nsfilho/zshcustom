#!/bin/bash
#
# Prepare your computer to receive the shell zsh with steroids
# Author: Nelio Santos (nsfilho@icloud.com)
#
function downloadPart() {
    partName=$1
    TEMPUTILS=$(mktemp)
    echo "↘️ Downloading: $partName -> $TEMPUTILS"
    if ! curl -sfL -o "$TEMPUTILS" "https://raw.githubusercontent.com/nsfilho/zshcustom/master/$partName"; then
        echo "❌ Failed to download [$partName] — aborting."
        rm -f "$TEMPUTILS"
        exit 1
    fi
    if [ ! -s "$TEMPUTILS" ]; then
        echo "❌ Downloaded file is empty [$partName] — aborting."
        rm -f "$TEMPUTILS"
        exit 1
    fi
    echo "🚀 Running: $partName"
    source "$TEMPUTILS"
    rm -f "$TEMPUTILS"
}

echo "📢 Starting support to elevate privileges..."
downloadPart "utils.sh"
downloadPart "configure.sh"
