# ~/.bash/aliases.sh with all the aliases

alias rldx='. ~/.bashrc'
alias rld='rldx && clear'
# quick aliases to the bash files
alias barc='micro ~/.bashrc'
alias benv='micro ~/.bash/env.sh'
alias bls='micro ~/.bash/aliases.sh'
alias balias='bls'
alias balia='bls'
alias bafun='micro ~/.bash/funcs.sh'
alias bafunc='bafun'
alias bapf='micro ~/.bash/profile.sh'
alias bafile='bapf'

# update upgrade
alias upd='sudo apt update'
alias upg='sudo apt upgrade'
alias up='upd && upg'

# interesting
alias fuck='reboot'
alias FUCK='shutdown now'

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

# Stands?! (sounds)
alias hando='(mpg123 -q -k 210 ~/Downloads/za_hando.mp3 &)'
alias HANDO='hando'
#alias warudo='(mpg123 -q -k 87 ~/Downloads/za_warudo.mp3 &)'
alias warudo='(mpg123 -q -n 100 ~/Downloads/za_warudo-stop_resume.mp3 &)'
alias WARUDO='warudo'

# Cools
alias cool='fastfetch'
# lkey wanna write that myself idk how it works so ill check it out later
alias lain='jp2a --height=25 -b --red=2.5 $Lain/lain_side.png'
alias well*3='jp2a --height=32 -i --color-depth=4 ~/Pictures/boys/boykisser.jpg'
alias cool2='lain'
alias cool3='for i in {232..255} {255..232} ; do echo -en "\e[38;5;${i}m$\e[0m" ; done ; echo'
#alias flag='echo -e "${_WHITEB}          \n${_REDB}          ${_CLR}"'

# Random
## icba changing that i got nano replaced with micro either way
alias nano="micro"
alias cpd="cp -r"
alias postman="~/Desktop/Postman/Postman"
alias rever="echo 'typo lol' && rerver"
alias rpi="ssh zilezia@$rpi"
alias c='xclip -selection clipboard'
alias v='xclip -o'
alias x='exit'
alias s='sudo'
alias q='x'
alias terminal='gnome-terminal'
alias new='terminal'
alias ok='echo ok'
alias fire='echo trve'
alias ire='fire'
alias tarr='tar -xvf'
alias rmd='rm -rf'
alias cl='clear'
alias cls='cl'
alias clr='cl'
alias l='ls -ACF'

# change to functions
alias l.='l ..'
alias cd.='cd ..'
alias cd..='cd. && cd.'
alias cd,='cd.'
alias files='xdg-open .'

# git
alias mgit="$browser https://github.com/Zilezia"
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
