# ~/.bash/aliases.sh with all the aliases
alias barc='nano ~/.bashrc'
alias balias='nano ~/.bash/aliases.sh'
alias bfunc='nano ~/.bash/funcs.sh'

alias up='sudo apt update && sudo apt upgrade'
alias upd='sudo apt update'
alias upg='sudo apt upgrade'

# interesting
alias fuck='reboot now'
alias FUCK='shutdown now'

alias snapi='sudo snap install "$1"'
alias apti='sudo apt install "$1"'
alias tarr='tar -xvf "$1"'
alias mkcd='mkdir -p -- "$1" && cd -P -- "$1"'
alias rmd='rm -rf "$1"'

alias reload='source ~/.bashrc'
alias cd.='cd ..'
alias cls='clear' # lol
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#alias alert='notify-send --urgency=low -i "([ $? = 0 ] && echo terminal || echo error)" "$(history|tail)"'
