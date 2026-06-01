#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This bootstrap is for macOS only."
  exit 1
fi

DOTFILES="/tmp/dotfiles"

# Clone repo if running via curl (no install.sh found locally)
if [ ! -f "$(dirname "$0")/install.sh" ]; then
  if [ -d "$DOTFILES" ]; then
    echo "Updating dotfiles..."
    git -C "$DOTFILES" pull
  else
    echo "Cloning dotfiles..."
    git clone https://github.com/lucasmiguelleite/dotfiles.git "$DOTFILES"
  fi
  cd "$DOTFILES"
else
  DOTFILES="$(cd "$(dirname "$0")" && pwd)"
  cd "$DOTFILES"
fi

echo "Installing dependencies..."

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install git zoxide atuin eza bat mise \
  zsh-history-substring-search zsh-autosuggestions \
  powerlevel10k neovim

brew install --cask font-meslo-lg-nerd-font claude-code codex

echo ""
echo "Installing dotfiles..."
exec "$DOTFILES/install.sh"
