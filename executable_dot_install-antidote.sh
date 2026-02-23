#!/usr/bin/env bash

echo "Installing Antidote"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

ZSHRC="$HOME/.zshrc"

cat <<'EOF' >> "$ZSHRC"
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

source ~/.zshrc_persist
EOF

echo "Configuration appended to $ZSHRC"
