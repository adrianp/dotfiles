#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Please supply the Linux distribution as the first argument, see files below."
    ls bashrc/ -l | grep -v ^d
    exit 65
fi

mv inputrc ~/.inputrc
mv screenrc ~/.screenrc
mv vimrc ~/.vimrc
mv bashrc/$1 ~/.bashrc
