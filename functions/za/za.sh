_za() {
    local cur
    local stands
    local opts opts_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    stands="warudo"
    opts="      --edit --help"
    opts_short=" -e     -h"

    COMPREPLY=(  $(compgen -W "${stands}"     -- ${cur}) )
    COMPREPLY+=( $(compgen -W "${opts}"       -- ${cur}) )
    COMPREPLY+=( $(compgen -W "${opts_short}" -- ${cur}) )
    return
}

za() {
    help() {
        echo "za [stand] <options>"
     echo -e "\nStands:"
        echo "  warudo          Stop everything briefly"
     echo -e "\nOptions:"
        echo "  -e, --edit      Edit source code"
        echo "  -h, --help      Display this help message"
        return
    }

    func() {
        #mpg123 ~/Downloads/za_warudo.mp3
        #nohup play ~/Downloads/za_warudo.mp3 -q -t alsa > /dev/null 2>&1 & disown
        (play ~/Downloads/za_warudo.mp3 -q -t alsa &)
        sleep 1 # takes time to say the words
        echo "stopping everything.."
        local count=10
        for i in $(seq $count); do
            echo "$is"
            sleep 1
        done
        echo "time resume"
    }

    case $1 in
        warudo)
            func;;
        -e | --edit)
            nano ${BASH_SOURCE[0]};;
        -h | --help | *)
            help;;
    esac
    return
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then za "$@"; fi
complete -F _za za
