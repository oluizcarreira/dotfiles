# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Configurações de Plugins (zstyle)
zstyle :omz:plugins:ssh-agent identities id_ed25519
zstyle ':histdb:*' connect-options --defaults
zstyle ':histdb:*' lock-git-repos-on-connect true

# Path para a instalação do Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(ssh-agent git docker docker-compose node python zsh-autosuggestions zsh-syntax-highlighting zsh-histdb)

source $ZSH/oh-my-zsh.sh

# Ativação do mise (com fallback seguro de localização)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
elif [ -f "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# =======================================================
# Aliases Personalizados
# =======================================================

# Gestão do PostgreSQL via mise
alias pgstart='pg_ctl -D "$(mise where postgres 2>/dev/null)/data" -l logfile start'
alias pgstop='pg_ctl -D "$(mise where postgres 2>/dev/null)/data" stop'
alias pgstatus='pg_ctl -D "$(mise where postgres 2>/dev/null)/data" status'

# Substituições modernas (eza e bat)
alias ls="eza --icons"
alias cat="bat --style=auto"

# Carregamento da configuração do Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh