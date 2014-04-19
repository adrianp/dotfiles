#!/bin/bash
set -o nounset
set -o errexit

xmodmap -e "clear Lock"
xmodmap -e "keysym Caps_Lock = Escape"
