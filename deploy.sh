#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Please supply the Linux distribution as the first argument, see files below."
    ls bashrc/ -l | grep -v ^d
    exit 65
fi

cp inputrc ~/.inputrc
cp screenrc ~/.screenrc
cp vimrc ~/.vimrc
cp bashrc/$1 ~/.bashrc
cp bashrc/bash_aliases/$1 ~/.bash_aliases
