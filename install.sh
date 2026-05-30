#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# home/ → ~/
for file in home/.*; do
  [ -f "$file" ] || continue
  target="$HOME/$(basename "$file")"
  ln -sfn "$DOTFILES/$file" "$target"
  echo "linked $file → $target"
done

# config/* → ~/.config/*
for dir in config/*/; do
  target="$HOME/.config/$(basename "$dir")"
  mkdir -p "$target"
  for file in "$dir"*; do
    [ -e "$file" ] || continue
    dest="$target/$(basename "$file")"
    ln -sfn "$DOTFILES/$file" "$dest"
    echo "linked $file → $dest"
  done
done

# zsh secrets
if [ ! -f "$HOME/.config/zsh/secrets" ]; then
  cp "$DOTFILES/config/zsh/secrets.example" "$HOME/.config/zsh/secrets"
  echo "created ~/.config/zsh/secrets — fill in your values"
fi

echo "done! restart your shell."
