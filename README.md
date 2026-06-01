# Dotfiles

Personal configuration files for macOS.

## Structure

```
├── bootstrap.sh          # Install dependencies (macOS only)
├── install.sh            # Copy configs to home directory
├── home/
│   ├── .gitconfig        → ~/.gitconfig (copy)
│   └── .zshrc            → ~/.config/zsh/.zshrc (copy, then symlinked from ~/)
└── config/
    ├── zsh/              → ~/.config/zsh/ (copy)
    ├── nvim/             → ~/.config/nvim/ (copy)
    ├── Code/User/        → ~/.config/Code/User/ (copy)
    ├── zed/              → ~/.config/zed/ (copy)
    ├── claude/           → ~/.claude/ + ~/.config/claude/ (copy)
    └── codex/            → ~/.codex/ (copy)
```

Only `~/.zshrc` is a symlink pointing to `~/.config/zsh/.zshrc`. All other files are copied only if they don't already exist. In `~/.config/claude/`, `settings.example.json` is renamed to `settings.json`.

## Setup

```sh
# One-liner (bootstrap + install)
bash <(curl -fsSL https://raw.githubusercontent.com/lucasmiguelleite/dotfiles/main/bootstrap.sh)

# Or manually:
git clone https://github.com/lucasmiguelleite/dotfiles.git
cd dotfiles
./bootstrap.sh
```

## Programs

- **Shell**: zsh + powerlevel10k
- **History**: atuin + zsh-history-substring-search + zsh-autosuggestions
- **Navigation**: zoxide + eza
- **Editor**: neovim (LazyVim) + Zed
- **Version manager**: mise
- **Terminal**: VS Code + vscode-neovim
- **AI**: Claude Code + Codex
