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

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# history size
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# Allow to review a history substitution result by loading the resulting line                     
# into the editing buffer, rather than directly executing it.
shopt -s histverify

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

# general aliases
alias ll='ls -oAhpv --color --group-directories-first'
alias ..='cd ..'
alias k='killall -v -u $USER'
alias rm='rm -Iv'
alias s='screen'
alias h='cd ~'
alias v='vim'
alias g='grep --color=auto -rn . -e'
alias c='clear'
alias gg='git gui &' # install git-gui for this
alias f='find . -name'
alias src='source ~/.bashrc'
alias _='sudo'

# Creates a directory and cd inside
function mkcd() {
  mkdir -p "$1"
  cd "$1";
}

# other aliases go in a separate file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# vim bash shell mode
set -o vi

# the bash shell prompt; show the load(1), day-of-month, time, login, host path,
# git branch, and virtualenv
function set_ps1 {
    green="\[\e[32;1m\]"
    red="\[\e[31;1m\]"
    cyan="\[\e[36;1m\]"
    orange="\[\e[91;1m\]"
    purple="\[\e[35;1m\]"
    yellow="\[\e[33;1m\]"
    nocol="\e[m"

    local git="$(__git_ps1)"
    local venv="${VIRTUAL_ENV##*/}"
    local load=$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g")

    export PS1="${green}${load}${nocol}|$(date +"%H:%M.")${yellow}$(date +"%d")${nocol}|\u@\h:${red}\w${nocol}${cyan}${git}${nocol}${purple}${venv}${nocol}$ ";
}
export PROMPT_COMMAND=set_ps1; history -a

# Include user's bin folder.
if [ -d "$HOME/bin" ] ; then
    export PATH=$HOME/bin:$PATH
fi

# we prefer vim for SVN, Git, etc.
export SVN_EDITOR=vim
export EDITOR=vim

#export PATH=$PATH:/home/...
