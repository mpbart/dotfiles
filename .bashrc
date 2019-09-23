# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

[ -f $HOME/.git_completion.sh ] && source $HOME/.git_completion.sh


# User specific aliases and functions
alias clera='clear'
alias dirs='dirs -v'
alias p='pushd'
alias o='popd'
alias vim='/usr/local/bin/vim'
alias gitpurge='git branch -d $(git branch --merged)'
set -o vi
alias gm='git checkout master && git pull'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
