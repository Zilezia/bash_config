# ~/.bash/aliases.sh with all the aliases

alias reload='. ~/.bashrc'
# quick aliases to the bash files
alias barc='nano ~/.bashrc'
alias balias='nano ~/.bash/aliases.sh'
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
alias snapi='sudo snap install "$1"'
## Apt
alias apti='sudo apt install "$1"'
alias aptarm='sudo apt autoremove "$1"'
alias aptrm='sudo apt remove "$1"'
alias aptu='sudo apt update'

# Cools
alias cool='fastfetch'
alias cool2='jp2a --height=25 -b --red=2.5 ~/Pictures/Lain/lain_side.png'

# Random
alias terminal='gnome-terminal'
alias new='terminal'
alias files='xdg-open .'
alias ok='echo ok'
alias snano='sudo nano'
alias tarr='tar -xvf "$1"'
alias rmd='rm -rf "$1"'
alias cls='clear' # lol
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CFA'
alias l.='l ..'

# have a function for this
alias cd.='cd ..'
alias cd..='cd .. && cd ..'

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
