# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# if not running interactively, don't do anything
#[ -z "$PS1" ] && return
case $- in
    *i*) ;;
      *) return;;
esac

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#bindirs=("/bin" "/sbin")
#bindir=${bindirs[$RANDOM % ${#bindirs[@]} ]}
#echo "Did you know this command: $(whatis $(ls ${bindir} | shuf -n 1)) ?"

#echo $(ddate)

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# history size
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# allow to review a history substitution result by loading the resulting line
# into the editing buffer, rather than directly executing it.
shopt -s histverify

# save multi-line commands as one command
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# bash completion auto-correction
shopt -s cdspell

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# add an "alert" alias for long running commands; use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Working autocompletion for aliases, see:
# http://ubuntuforums.org/showthread.php?t=733397
function make-completion-wrapper () {
    local function_name="$2"
    local arg_count=$(($#-3))
    local comp_function_name="$1"
    shift 2
    local function="
function $function_name {
    ((COMP_CWORD+=$arg_count))
    COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
    "$comp_function_name"
    return 0
}"
    eval "$function"
}

# !!<space> will replace the !! with your last command
bind Space:magic-space

# treat hyphens and underscores as equivalent for completion
bind "set completion-map-case on"

# display completion matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

source /home/tudor/src/dotfiles/scripts/git-completion.sh
source /home/tudor/src/dotfiles/scripts/git-prompt.sh

# general aliases
alias q='exit'
alias d='du -h'
alias l='ls -oAhpv --color --group-directories-first'
alias k='killall -v -i -s 9 -u $USER'
alias rm='rm -I'
alias t2='tmux -2'
alias t='tmux attach'
alias ~='cd ~'
alias b='cd -'
alias v='nvim'
alias gp='grep --color=auto -rn . -e'
alias c='reset'
alias gg='gitk'
alias f='find . -name'
alias src='source ~/.bashrc'
alias srcd='cd ~/src/dotfiles'
alias _='sudo'
alias p='ps -alyH --forest'
alias pn='ping -OD'
alias pud='pushd'
alias pudd='pushd .'
alias pod='popd'
alias dr='dirs'
alias vrc='nvim ~/.vimrc'
alias mp='mkdir -p'
alias tree='tree -aFC --dirsfirst -L 7 -I .git'
alias r='ranger .'
alias js='node'
alias cdv='cdvirtualenv'
alias ds='dig +short'
alias off='sudo poweroff'
alias fuck='sudo $(history -p \!\!)'  # repeat last command with sudo
alias epoch='date +%s'
alias wan='dig +short myip.opendns.com @resolver1.opendns.com'
alias u='uptime'
alias rlf='readlink -f'
alias vimdiff='nvim -d'

alias g='git'
complete -o default -o nospace -F _git g

alias gnwd='~/bin/git-new-workdir.sh'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# kills a process tree specified by the root
function exterminate() {
    kill -9 -$(ps | grep $1 | grep -v grep | awk '{print $1}')
}

# creates a directory tree (linear) with a file leaf
function mktree() {
    mkdir -p $1
    touch $1/$2
}

# creates a directory and navigates to it
function mkcd() {
    mkdir -p "$1"
    cd "$1";
}

# navigates to a directory and lists it
function cl() {
    if [ -d $1 ]; then
        cd $1
    else
        cd $HOME
    fi
    ls
}

# other aliases go in a separate file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# vim bash shell mode
set -o vi

LASTCMD=$(date +%s)

# the bash shell prompt; shows the load(1), time, day-of-month, login, host path,
# git branch, and virtualenv
function set_ps1 {
    green="\[\e[32;2m\]"
    orange="\[\e[33;1m\]"
    red="\[\e[31;1m\]"
    cyan="\[\e[34;1m\]"
    purple="\[\e[38;5;91;1m\]"
    nocol="\e[m"

    # calcultate time since last prompt
    local _now=$(date +%s)
    local _diff=$( printf "%02d:%02d:${orange}%02d${nocol}" \
           $((  ( _now - LASTCMD ) / 3600))         \
           $(( (( _now - LASTCMD ) % 3600) / 60 )) \
           $((  ( _now - LASTCMD ) % 60))           \
       )
    LASTCMD=${_now}

    local git=$(__git_ps1 " (%s)")
    if [[ -z $git ]]; then
        git=" "
    fi
    if [[ -z ${VIRTUAL_ENV##*/} ]]; then
        local venv=""
    else
        local venv="<${VIRTUAL_ENV##*/}>"
    fi
    local load=$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g")

    export PS1="${red}${load}${nocol}|${cyan}\j${nocol}|${_diff}|$(date +"%H:%M.")${cyan}$(date +"%d")${nocol}|\u@${red}\h${nocol}:${green}\w${nocol}${purple}${git}${nocol}${red}${venv}${nocol}\n$ ";
}
export PROMPT_COMMAND=set_ps1

# after each command, save and reload history: http://unix.stackexchange.com/questions/1288
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# include user's bin/ directory
if [ -d "$HOME/bin" ]; then
    export PATH=$HOME/bin:$PATH
fi

# we prefer nvim for SVN, Git, etc.
export SVN_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# git-prompt exports
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto git"
#export GIT_PS1_DESCRIBE_STYLE=branch

# actually see Python output in some environments like Foreman
#export PYTHONUNBUFFERED=True

# Heroku Toolbelt: https://toolbelt.heroku.com/
export PATH="/usr/local/heroku/bin:$PATH"

# Go development
#export PATH=$PATH:$(go env GOPATH)/bin
#export GOPATH=$(go env GOPATH)

#source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper_lazy
. "$HOME/.cargo/env"
