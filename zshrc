export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey -e

# history options
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
bindkey '^R' history-incremental-search-backward

export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/opt/mariadb@10.1/bin:$PATH"

# Setting PATH for Python 3 installed by brew
export PATH=/usr/local/share/python:$PATH

# Configuration for virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh


# Load version control information
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git*' actionformats "%s  %r/%S %b %m%u%c "
zstyle ':vcs_info:git*' formats "[%b:%u%c%m] "
precmd() { vcs_info }

setopt prompt_subst
PROMPT='%(1j.[%F{red}%j%f] .)${vcs_info_msg_0_}%n%f@%F{yellow}%m%f%(!.%F{red}.):%{$(pwd|grep --color=always /)%${#PWD}G%}%(!.%F{red}.%F{cyan})$%f '

# general aliases
alias q='exit'
alias d='du -h'
alias l='ls -oAhpvG'
alias k='killall -v -i -s 9 -u $USER'
alias t='tmux attach'
alias ~='cd ~'
alias b='cd -'
alias v='mvim -v'
alias gp='grep --color=auto -rn . -e'
alias c='reset'
alias gg='gitk'
alias f='find . -name'
alias src='source ~/.zshrc'
alias srcd='cd ~/src/dotfiles'
alias p='ps -alyH --forest'
alias pn='ping -OD'
alias pud='pushd'
alias pudd='pushd .'
alias pod='popd'
alias dr='dirs'
alias vrc='vim ~/.vimrc'
alias mp='mkdir -p'
alias tree='tree -aFC --dirsfirst -L 7 -I .git'
alias r='ranger .'
alias js='node'
alias cdv='cdvirtualenv'
alias ds='dig +short'
alias epoch='date +%s'
alias wan='dig +short myip.opendns.com @resolver1.opendns.com'
alias u='uptime'
alias rlf='readlink -f'
alias g='git'
alias vim='mvim -v'
alias up='brew update && brew upgrade && brew cleanup'
alias dcr='docker-compose run --service-ports'

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

bindkey "^[[1~" beginning-of-line # home
bindkey "^[[4~" end-of-line # end
