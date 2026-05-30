source ~/.config/zsh/shell
source ~/.config/zsh/init
source ~/.config/zsh/envs
source ~/.config/zsh/aliases
[[ -r ~/.config/zsh/secrets ]] && source ~/.config/zsh/secrets

# bun completions
[ -s "/Users/lucasleite/.bun/_bun" ] && source "/Users/lucasleite/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude-mem='/Users/lucasleite/.bun/bin/bun "/Users/lucasleite/.claude/plugins/cache/thedotmack/claude-mem/10.6.3/scripts/worker-service.cjs"'
