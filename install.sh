#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# home/ → ~/ (skip .zshrc — handled below via symlink)
for file in home/.*; do
  [ -f "$file" ] || continue
  name="$(basename "$file")"
  [ "$name" = ".zshrc" ] && continue
  [ -f "$HOME/$name" ] && continue
  cp "$file" "$HOME/$name"
  echo "copied $name → ~/$name"
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
      [ -f "$dest/$name" ] && continue
      cp "$item" "$dest/$name"
      echo "copied $name → $dest/$name"
    fi
  done
}

for dir in config/*/; do
  name="$(basename "$dir")"
  case "$name" in
    claude)
      copy_dir "$dir" "$HOME/.claude"
      copy_dir "$dir" "$HOME/.config/$name"
      # rename example → real filename in ~/.config/claude/
      [ -f "$HOME/.config/$name/settings.example.json" ] && \
        mv "$HOME/.config/$name/settings.example.json" "$HOME/.config/$name/settings.json"
      ;;
    codex) copy_dir "$dir" "$HOME/.codex" ;;
    *)     copy_dir "$dir" "$HOME/.config/$name" ;;
  esac
done

# ~/.zshrc symlink → ~/.config/zsh/.zshrc
ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
echo "linked ~/.zshrc → ~/.config/zsh/.zshrc"

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
