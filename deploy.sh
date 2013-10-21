#!/bin/bash

# where are the dotfiles stored (location of this script)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the name of the files to deploy; notice that we skip .bash_aliases and
# .jshintrc
DOTFILES=( "bashrc" "gitconfig" "inputrc" "screenrc" "vimrc" )

mkdir ~/tmp
mkdir ~/tmp/dotfiles_backup

for file in "${DOTFILES[@]}"
do
	mv ~/.$file ~/tmp/dotfiles_backup/ # backup the existing dotfile
	ln -s $DIR/$file ~/.$file # link the new dotfile
done

# create an empty .bash_aliases file
touch $DIR/bash_aliases
mv ~/.bash_aliases ~/tmp/dotfiles_backup/
ln -s $DIR/bash_aliases ~/.bash_aliases

source ~/.bashrc

# deploy the Git diff script
mkdir ~/bin
ln -s $DIR/diff.py ~/bin/diff.py
chmod +x ~/bin/diff.py

# ln -s jshintrc ~/.jshintrc
# ln -s Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
