# ~/.bash/aliases.sh with all the aliases

alias rldx='. ~/.bashrc'
alias rld='rldx && clear'
# quick aliases to the bash files
alias barc='nano ~/.bashrc'
alias benv='nano ~/.bash/env.sh'
alias bls='nano ~/.bash/aliases.sh'
alias balias='bls'
alias bafun='nano ~/.bash/funcs.sh'
alias bafunc='bafun'
alias bapf='nano ~/.bash/profile.sh'
alias bafile='bapf'

# update upgrade
alias upd='sudo apt update'
alias upg='sudo apt upgrade'
alias up='upd && upg'

# interesting
alias fuck='sudo reboot now'
alias FUCK='sudo shutdown now'

# Package Managers
## DPKG
alias debi='sudo dpkg -i'
alias debil='debi'
## Snap
alias snapi='sudo snap install'
## Apt
alias apti='sudo apt install'
alias aptarm='sudo apt autoremove'
alias aptrm='sudo apt remove'
alias aptu='sudo apt update'

# Cools
alias cool='fastfetch'
alias lain='jp2a --height=25 -b --red=2.5 $Lain/lain_side.png'
alias cool2='lain'
alias cool3='for i in {232..255} {255..232} ; do echo -en "\e[38;5;${i}m$\e[0m" ; done ; echo'

# Random
alias postman="~/Desktop/Postman/Postman"
alias rever="echo 'typo lol' && rerver"
alias rpi="ssh zilezia@$rpi"
alias c='xclip -selection clipboard'
alias v='xclip -o'
alias x='exit'
alias terminal='gnome-terminal'
alias new='terminal'
alias ok='echo ok'
alias snano='sudo nano'
alias tarr='tar -xvf'
alias rmd='rm -rf'
alias cl='clear'
alias cls='cl'
alias l='ls -ACF'

# change to functions
alias l.='l ..'
alias cd.='cd ..'
alias cd..='cd. && cd.'
alias cd,='cd.'
alias files='xdg-open .'

# git
alias glone='git clone'
alias glon='glone'
alias gadd='git add .'
alias gyatt='gadd'
alias gyat='gadd'
alias gus='git status'
alias gom='git commit -m'
alias gstat='gus'
alias gush='git push'
alias gushu='gush -u origin main'
alias granch='git branch -v'
alias gemote='git remote -v'
alias gremote='gemote'
alias grem='gemote'

# MySQL/SQL
alias rsql='mysql -u root -p' # no sudo to avoid double password typing

# Rust
## Cargo
alias carc='cargo c'
alias carC='cargo clean'
alias carb='cargo b'
alias carB='cargo b -r'
alias carr='cargo r'
alias carR='cargo r -r'

## Trunk
alias trunb='trunk build'
alias trunB='trunk build --release'
alias trunc='trunk clean'
alias truns='trunk serve'
alias trunS='trunk serve --release'
