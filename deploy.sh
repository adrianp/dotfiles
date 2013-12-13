# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

#!/bin/bash

# where are the dotfiles stored (location of this script)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the name of the files to deploy; notice that we skip .bash_aliases and
# .jshintrc
DOTFILES=( "bashrc" "gitconfig" "inputrc" "screenrc" "vimrc" )

mkdir ~/var
mkdir ~/var/dotfiles_backup

for file in "${DOTFILES[@]}"
do
	mv ~/.$file ~/var/dotfiles_backup/$file # backup the existing dotfile
	ln -s $DIR/$file ~/.$file # link the new dotfile
done

# create an empty .bash_aliases file
touch $DIR/bash_aliases
mv ~/.bash_aliases ~/var/dotfiles_backup/
ln -s $DIR/bash_aliases ~/.bash_aliases

mkdir ~/bin
cp $DIR/scripts/git-completion.sh ~/bin/git-completion.sh
chmod +x ~/bin/git-completion.sh
cp $DIR/scripts/git-new-workdir.sh ~/bin/git-new-workdir.sh
chmod +x ~/bin/git-new-workdir.sh
cp $DIR/scripts/git-prompt.sh ~/bin/git-prompt.sh
chmod +x ~/bin/git-prompt.sh

source ~/.bashrc

# ln -s jshintrc ~/.jshintrc
# rm ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
# ln -s Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
# cp terminalrc ~/.config/xfce4/terminal/terminalrc
