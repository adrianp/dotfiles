# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

alias up='sudo apt update; sudo apt full-upgrade; sudo apt-get autoremove -y'
alias autoremove='sudo apt-get autoremove -y'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias apts='apt-cache search'
alias dinstall='sudo dpkg -i'
alias ns='echo "sudo tc qdisc add dev wlan0 root netem delay 200ms" && sudo tc qdisc change dev wlan0 root netem delay 200ms'
alias nf='sudo tc qdisc change dev wlan0 root netem delay 0ms'
alias osup='sudo do-release-upgrade -d'
alias mkv3='mkvirtualenv -p python3.7'
alias dup='sudo -E COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up'
alias gopro='sudo gopro webcam -r 1080 -f narrow -a' # https://github.com/jschmid1/gopro_as_webcam_on_linux
alias black='python3 -m black -l 120 -t py37' # pip3 install git+https://github.com/psf/black

alias serv='sudo service'
make-completion-wrapper _service _serv service
complete -F _serv serv
