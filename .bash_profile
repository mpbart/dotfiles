# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxCxegedabagaced
alias ls='ls -GH'

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

