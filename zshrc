# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/adrianp/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey '^R' history-incremental-search-backward

# aliases
alias update="sudo yum update"
alias pico="nano"
alias clr="clear"
alias matlab="/usr/local/MATLAB/R2011b/bin/matlab &"
alias sublime="/home/adrianp/bin/Sublime\ Text\ 2/sublime_text &"

# mkdir + cd
function mkcd() { mkdir "$@"; cd "$@" }

# cd + ls
function cls() { cd $1 && ls -A}

autoload -U promptinit
promptinit
prompt redhat
