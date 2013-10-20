#!/bin/bash

# where are the dotfiles stored (location of this script)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the name of the files to deploy; notice that we skip .bash_aliases and
# .jshintrc
DOTFILES=( "bashrc", "gitconfig", "inputrc", "screenrc", "vimrc" )

mkdir ~/var
mkdir ~/var/dotfiles_backup

for file in "${DOTFILES[@]}"
do
	mv ~/.$file ~/var/dotfiles_backup/.$file # backup the existing dotfile
	ln -s $DIR/$file ~/.$file # link the new dotfile
done

# create an empty .bash_aliases file
touch ~/.bash_aliases

# deploy the Git diff script
mkdir ~/bin
ln -s $DIR/diff.py ~/bin/diff.py
chmod +x ~/bin/diff.py