# Set vault related env vars
export VAULT_CACERT="/etc/pki/tls/certs/AvantCorporationCA.crt"
export VAULT_ADDR="https://vault.internal.amount.com"
export PYENV_VERSION=3.7.7

# Set up some paths
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export NVM_DIR="$HOME/.nvm"

export EDITOR='nvim'
export VISUAL='nvim'

export CLICOLOR=1
export LSCOLORS=ExFxCxDxCxegedabagaced

# fzf
export FZF_DEFAULT_COMMAND='ag --ignore-dir=persisted-data --ignore-dir=.git --ignore-dir=staging_fixtures --hidden -g ""' # Find hidden and non-git files
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
