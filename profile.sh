_CLR="\e[0m"
_CLRB="\e[49m"
_CLRF="\e[39m"

_BOLD="\e[1m"
_DIM="\e[2m"
_UNDER="\e[4m"
_BLINK="\e[5m"
_INV="\e[7m"
_HIDE="\e[8m"

# foreground
_WHITEF="\e[97m"
_BLACKF="\e[30m"
_MAGF="\e[38;5;200m"
_BLUEF="\e[38;5;4m"
_GREENF="\e[38;5;10m"
_GOLDF="\e[38;5;220m"
# background
_WHITEB="\e[107m"
_BLACKB="\e[40m"
_MAGB="\e[48;5;200m"
_BLUEB="\e[48;5;21m"
_REDB="\e[48;5;196m"

# this is breaking my terminal but im keeping it atm without fixing cuz it looks fire
#export PS1="${_BOLD}${_MAGF}\u${_WHITEF}: ${_GOLDF}\$(if [[ \$PWD == \$HOME ]]; then echo '~'; elif [[ \$PWD == / ]]; then echo '/'; else echo -e \"${_WHITEF}\w\"; fi) ${_BOLD}${_GREENF}\$${_CLR} "
export PS1="${_BOLD}${_MAGF}\u${_WHITEF}: \$(echo -e \"${_WHITEF}\w\" | sed 's|~|\\[${_GOLDF}\\]~\\[${_WHITEF}\\]|g') ${_BOLD}${_GREENF}\$${_CLR} "

# bash
export bash=~/.bash
export bafun=$bash/functions
export bafunc=$bafun

export Lain=~/Pictures/Lain
export lain=$Lain

export rpi=192.168.1.190

export browser=vivaldi

# Projects dir
export Kode=~/Kode
if [[ ! -d $Kode ]]; then
    export Kode=~/Documents
fi

## Projects
export zilezia=$Kode/zilezia.dev
export zilezia_dev=$zilezia
export site=$zilezia
export ZILEZIA_ENV=$zilezia/.env
export ZILEZIA_DEV_ENV=$ZILEZIA_ENV

export pet_crem=$Kode/pet_crem
export PET_CREM_ENV=$pet_crem/.env

export bisser=$Kode/koybisser
export koy_bisser=$bisser
export BISSER_ENV=$bisser/.env
export KOY_BISSER_ENV=$bisser/.env

### forgot about this one
export RoPC=$Kode/RoPC_plugin
export ropc=$RoPC
