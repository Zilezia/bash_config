# ~/.bash/aliases.sh with all the aliases
alias barc='nano ~/.bashrc'
alias balias='nano ~/.bash/aliases.sh'
alias bfunc='nano ~/.bash/funcs.sh'

alias up='sudo apt update && sudo apt upgrade'
alias upd='sudo apt update'
alias upg='sudo apt upgrade'

# interesting
alias fuck='sudo reboot now'
alias FUCK='sudo shutdown now'

alias snapi='sudo snap install "$1"'
alias apti='sudo apt install "$1"'
alias tarr='tar -xvf "$1"'
alias mkcd='mkdir -p -- "$1" && cd -P -- "$1"'
alias rmd='rm -rf "$1"'

#alias reloadx="x-terminal-emulator && wmctrl -r ':ACTIVE:' -b toggle,fullscreen"
alias reload='source ~/.bashrc'
alias cd.='cd ..'
alias cls='clear' # lol
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#alias alert='notify-send --urgency=low -i "([ $? = 0 ] && echo terminal || echo error)" "$(history|tail)"'

# git
# ofc this hasnt worked, gotta make a function
# alias gush='git add . && git commit -m "\"$1\"" && git push'

# MySQL/SQL
alias rsql='mysql -u root -p' # no sudo to avoid double password typing

# Rust
alias carr='cargo r'
alias carR='cargo r -r'
alias carc='cargo c'
alias carC='cargo clean'

# Nicher, Trunk
alias trunb='trunk build'
alias trunB='trunk build --release'
alias trunc='trunk clean'
