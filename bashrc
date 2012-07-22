# .bashrc
# Used in Fedora 17

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# custom prompt; shows time and absolute path
PS1="$(date +"%H:%M") \u@\h:\w $ "; 
export PS1

# User specific aliases and functions
alias update="sudo yum update"
