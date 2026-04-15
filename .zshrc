# Already have
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='bat --style=plain --paging=never'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph'

# Nix
alias nrs='sudo nixos-rebuild switch'
alias nrb='sudo nixos-rebuild boot'
alias nconf='sudo nano /etc/nixos/configuration.nix'

# Tools
alias top='btop'
alias ff='fastfetch'
alias grep='rg'
alias find='fd'

# Docker
alias dps='docker ps'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

reset_command() {
  reset            # Replace with your actual command
  zle redisplay      # Refreshes the prompt after the command runs
}

zle -N reset_command
bindkey '^l' reset_command
export EDITOR=vim
