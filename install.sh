#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# config/* → destinations
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

copy_dir_exclude() {
  local src="$1" dest="$2" exclude="$3"
  mkdir -p "$dest"
  for item in "$src"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"
    [[ "$name" == $exclude ]] && continue
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
      copy_dir_exclude "$dir" "$HOME/.claude" "settings.*.json"
      ;;
    codex)  copy_dir "$dir" "$HOME/.codex" ;;
    *)      copy_dir "$dir" "$HOME/.config/$name" ;;
  esac
done

# .gitconfig → ~/ (only if doesn't exist)
[ -f "$HOME/.gitconfig" ] || {
  cp "$DOTFILES/config/.gitconfig" "$HOME/.gitconfig"
  echo "copied .gitconfig → ~/.gitconfig"
}

# ~/.zshrc symlink → ~/.config/zsh/.zshrc
ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
echo "linked ~/.zshrc → ~/.config/zsh/.zshrc"

# zsh secrets
if [ ! -f "$HOME/.config/zsh/secrets" ]; then
  cp "$DOTFILES/config/zsh/secrets.example" "$HOME/.config/zsh/secrets"
  echo "created ~/.config/zsh/secrets — fill in your values"
fi

# claude code settings (ask before overwriting)
if [ -f "$HOME/.claude/settings.json" ]; then
  read -p "Overwrite ~/.claude/settings.json? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "1) Anthropic (official)"
    echo "2) Z.ai"
    read -p "Choose provider: [1/2] " provider
    case "$provider" in
      2) cp "$DOTFILES/config/claude/settings.zai.json" "$HOME/.claude/settings.json"
         echo "copied settings.zai.json → ~/.claude/settings.json" ;;
      *) cp "$DOTFILES/config/claude/settings.anthropic.json" "$HOME/.claude/settings.json"
         echo "copied settings.anthropic.json → ~/.claude/settings.json" ;;
    esac
  else
    echo "skipped ~/.claude/settings.json"
  fi
else
  cp "$DOTFILES/config/claude/settings.anthropic.json" "$HOME/.claude/settings.json"
  echo "created ~/.claude/settings.json — fill in your tokens"
fi

echo "done! restart your shell."
