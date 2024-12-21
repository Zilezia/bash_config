# ~/.bash/aliases.sh with all the aliases

alias reload='. ~/.bashrc'
# quick aliases to the bash files
alias barc='nano ~/.bashrc'
alias balias='nano ~/.bash/aliases.sh'
alias bls='balias'
alias bafunc='nano ~/.bash/funcs.sh'
alias bafun='nano ~/.bash/funcs.sh'
alias bapf='nano ~/.bash/profile.sh'
alias bafile='nano ~/.bash/profile.sh'

# update upgrade
alias up='sudo apt update && sudo apt upgrade'
alias upd='sudo apt update'
alias upg='sudo apt upgrade'

# interesting
alias fuck='sudo reboot now'
alias FUCK='sudo shutdown now'

# Package Managers
## Snap
alias snapi='sudo snap install'
## Apt
alias apti='sudo apt install'
alias aptarm='sudo apt autoremove'
alias aptrm='sudo apt remove'
alias aptu='sudo apt update'

# Cools
alias cool='fastfetch'
alias lain='jp2a --height=25 -b --red=2.5 ~/Pictures/Lain/lain_side.png'
alias cool2='lain'

# Random
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
alias cd,='cd ..'
alias cd.='cd ..'
alias cd..='cd .. && cd ..'
alias files='xdg-open .'

# git
alias gus='git status'
alias gstat='git status'
alias gush='git push'

# MySQL/SQL
alias rsql='mysql -u root -p' # no sudo to avoid double password typing

# Rust
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
