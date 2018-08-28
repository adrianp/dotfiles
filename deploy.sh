# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

#!/bin/bash
set -o nounset
set -o errexit

# where are the dotfiles stored (location of this script)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#DOTFILES=( "bashrc" "gitconfig" "inputrc" "vimrc" "jsbeautifyrc" "eslintrc" "tmux.conf" )
DOTFILES=( "bashrc" "gitconfig" "inputrc" "vimrc" "tmux.conf" )

mkdir ~/var || true
mkdir ~/var/dotfiles_backup
mkdir ~/var/vim

for file in "${DOTFILES[@]}"
do
    mv ~/.$file ~/var/dotfiles_backup/$file || true  # backup the existing dotfile
    ln -s $DIR/$file ~/.$file
done

# create an empty .bash_aliases file
touch $DIR/bash_aliases  # note that if this files exists for some reason, it won't be overwritten
mv ~/.bash_aliases ~/var/dotfiles_backup/ || true
ln -s $DIR/bash_aliases ~/.bash_aliases

echo "Do not forget to source .bashrc!"

mkdir ~/bin || true
SCRIPTS=( "git-completion.sh" "git-new-workdir.sh" "git-prompt.sh")

for file in "${SCRIPTS[@]}"
do
    cp $DIR/scripts/$file ~/bin/$file  # FIXME: do we really need to cp, ln does not work?
    chmod +x ~/bin/$file
done

# links don't work for this file
#mkdir ~/.config || true && mkdir ~/.config/xfce4 || true && mkdir ~/.config/xfce4/terminal || true
#cp $DIR/terminalrc ~/.config/xfce4/terminal/terminalrc

#mkdir ~/.ssh || true
ln -s $DIR/ssh.config ~/.ssh/config

echo "Done!"
