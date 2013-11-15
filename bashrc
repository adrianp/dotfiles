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

# allow to review a history substitution result by loading the resulting line
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


# general aliases
alias ll='ls -oAhpv --color --group-directories-first'
alias ..='cd ..'
alias k='killall -v -u $USER'
alias rm='rm -I'
alias s='screen -R'
alias ~='cd ~'
alias b='cd -'
alias v='vim'
alias g='grep --color=auto -rn . -e'
alias c='clear'
alias gg='git gui &' # install git-gui for this
alias f='find . -name'
alias src='source ~/.bashrc'
alias _='sudo'

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

# the bash shell prompt; shows the load(1), time, day-of-month, login, host path,
# git branch, and virtualenv
function set_ps1 {
    green="\[\e[32;2m\]"
    red="\[\e[31;1m\]"
    cyan="\[\e[34;1m\]"
    purple="\[\e[38;5;91;1m\]"
    nocol="\e[m"

    local git="$(__git_ps1)"
    if [[ -z $git ]]; then
        git=" "
    fi
    if [[ -z ${VIRTUAL_ENV##*/} ]]; then
        local venv=""
    else
        local venv="<${VIRTUAL_ENV##*/}>"
    fi
    local load=$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g")

    export PS1="${red}${load}${nocol}|$(date +"%H:%M.")${cyan}$(date +"%d")${nocol}|\u@\h:${green}\w${nocol}${purple}${git}${nocol}${red}${venv}${nocol}\n$ ";
}
export PROMPT_COMMAND=set_ps1; history -a

# include user's bin/ directory
if [ -d "$HOME/bin" ]; then
    export PATH=$HOME/bin:$PATH
fi

# we prefer vim for SVN, Git, etc.
export SVN_EDITOR=vim
export EDITOR=vim
export VISUAL=vim

#export PATH=$PATH:/home/...
