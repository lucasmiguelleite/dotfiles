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
link_dir() {
  local src="$1" dest="$2"
  mkdir -p "$dest"
  for item in "$src"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"
    if [ -d "$item" ]; then
      link_dir "$item" "$dest/$name"
    else
      ln -sfn "$DOTFILES/$item" "$dest/$name"
      echo "linked $item → $dest/$name"
    fi
  done
}

for dir in config/*/; do
  link_dir "$dir" "$HOME/.config/$(basename "$dir")"
done

# zsh secrets
if [ ! -f "$HOME/.config/zsh/secrets" ]; then
  cp "$DOTFILES/config/zsh/secrets.example" "$HOME/.config/zsh/secrets"
  echo "created ~/.config/zsh/secrets — fill in your values"
fi

echo "done! restart your shell."
