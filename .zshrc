if [ -f /etc/zshrc ]; then
  . /etc/zshrc
fi

# Set up env vars
source ~/.zshenv

# Customize the prompt
PROMPT=$'%F{white}%~ %B%F{blue}~>%f%b '

# Set up paths and init various scripts to manage versions
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# Use a node version compatible with coc.vim
nvm use v14.15.4
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
eval "$(rbenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Get git completion
[ -f $HOME/.git_completion.zsh ] && source $HOME/.git_completion.zsh

# Set some zsh options http://zsh.sourceforge.net/Doc/Release/Options.html#Options
setopt \
  HIST_SAVE_NO_DUPS \
  HIST_IGNORE_SPACE \
  INC_APPEND_HISTORY \
  SHARE_HISTORY \
  GLOB_COMPLETE \
  NO_BEEP \
  EXTENDED_GLOB \
  DOT_GLOB \
  NOMATCH \
  AUTO_CD \
  NOTIFY

cdpath=($HOME/git)

# select viins keymap
bindkey -e

# Bind ctrl-r to reverse history search
bindkey "^R" history-incremental-search-backward

# Bind cmd+k (via iterm2 key mapping) to accept and execute auto suggestion
bindkey "^[-" autosuggest-execute

# Bind ctrl-o to end of line
bindkey "^O" vi-end-of-line

# Set up autocompletion
autoload -Uz compinit; compinit

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi


if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zsh/fzf
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.fzf.zsh

# User specific aliases and functions
alias ls='ls -GH'
alias ll="ls -l"
alias clera='clear'
alias dirs='dirs -v'
alias p='pushd'
alias o='popd'
alias vim='/usr/local/bin/vim'
alias old_gitpurge='git branch -d $(git branch --merged)'
alias gitpurge='~/compare_branches.rb'
alias removeoobs='gb | grep oob | xargs git branch -D $1'
alias console='avant console read us'
alias vi='/usr/local/bin/nvim'
alias vim='/usr/local/bin/nvim'
alias rspec='bundle exec rspec'
alias virtualenv='pyenv-virtualenvwrapper'
alias vd='source ~/.pyenv/versions/env/bin/activate && python ~/files.py $1 $2'
alias gm='git checkout master && git pull'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias vlogin="vault login -method=okta -address=$VAULT_ADDR username=mpb01e@amount.com"
alias dcr='docker-compose exec web bundle exec rspec $@'
alias dce='docker-compose exec $@'
alias dcu='docker-compose up'
