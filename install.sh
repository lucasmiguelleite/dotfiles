#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# home/ → ~/
for file in home/.*; do
  [ -f "$file" ] || continue
  cp -f "$file" "$HOME/$(basename "$file")" 2>/dev/null
  echo "copied $(basename "$file") → ~/$(basename "$file")"
done

# config/* → ~/.config/*
copy_dir() {
  local src="$1" dest="$2"
  mkdir -p "$dest"
  for item in "$src"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"
    if [ -d "$item" ]; then
      copy_dir "$item" "$dest/$name"
    else
      cp -f "$item" "$dest/$name" 2>/dev/null
      echo "copied $name → $dest/$name"
    fi
  done
}

for dir in config/*/; do
  name="$(basename "$dir")"
  case "$name" in
    claude) copy_dir "$dir" "$HOME/.claude" ;;
    codex) copy_dir "$dir" "$HOME/.codex" ;;
    *)     copy_dir "$dir" "$HOME/.config/$name" ;;
  esac
done

# zsh secrets
if [ ! -f "$HOME/.config/zsh/secrets" ]; then
  cp "$DOTFILES/config/zsh/secrets.example" "$HOME/.config/zsh/secrets"
  echo "created ~/.config/zsh/secrets — fill in your values"
fi

# claude code settings
if [ ! -f "$HOME/.claude/settings.json" ]; then
  cp "$DOTFILES/config/claude/settings.example.json" "$HOME/.claude/settings.json"
  echo "created ~/.claude/settings.json — fill in your tokens"
fi

echo "done! restart your shell."
