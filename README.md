# Dotfiles

Personal configuration files for macOS.

## Structure

```
├── bootstrap.sh          # Install dependencies (macOS only)
├── install.sh            # Symlink configs to home directory
├── home/
│   ├── .zshrc            → ~/.zshrc
│   └── .gitconfig        → ~/.gitconfig
└── config/
    ├── zsh/              → ~/.config/zsh/
    ├── nvim/             → ~/.config/nvim/
    ├── Code/User/        → ~/.config/Code/User/
    ├── zed/              → ~/.config/zed/
    ├── claude/           → ~/.claude/
    └── codex/            → ~/.codex/
```

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
