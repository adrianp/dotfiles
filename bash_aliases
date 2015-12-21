# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

alias up='sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y'
alias autoremove='sudo apt-get autoremove -y'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias apts='apt-cache search'
alias dinstall='sudo dpkg -i'
alias ns='echo "sudo tc qdisc add dev eth0 root netem delay 200ms" && sudo tc qdisc change dev eth0 root netem delay 200ms'
alias nf='sudo tc qdisc change dev eth0 root netem delay 0ms'
alias rdm='xfwm4 --replace &'
alias dy='youtube-dl --extract-audio --audio-format mp3'
alias osup='sudo do-release-upgrade -d'

alias serv='sudo service'
make-completion-wrapper _service _serv service
complete -F _serv serv
