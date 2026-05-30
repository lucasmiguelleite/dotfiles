#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This bootstrap is for macOS only."
  exit 1
fi

echo "Installing dependencies..."

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install git zoxide atuin eza bat mise \
  zsh-history-substring-search zsh-autosuggestions \
  powerlevel10k neovim

brew install --cask font-meslo-lg-nerd-font

echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo "Done! Now run ./install.sh to link dotfiles."
