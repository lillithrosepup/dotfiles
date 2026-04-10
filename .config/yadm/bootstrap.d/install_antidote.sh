#!/usr/bin/env bash

echo "Installing Antidote"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

ZSHRC="$HOME/.zshrc"

cat <<'EOF' >> "$ZSHRC"
# Load Antidote plugin manager
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# Load git-tracked dotfiles
source ~/.zshrc.persist

# Local zsh
EOF

echo "Configuration appended to $ZSHRC"
