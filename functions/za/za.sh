_za() {
    local cur opts opts_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="      --edit --help"
    opts_short=" -e     -h"

    COMPREPLY=(  $(compgen -W "${opts}"       -- ${cur}) )
    COMPREPLY+=( $(compgen -W "${opts_short}" -- ${cur}) )
    return
}

za() {
    help() {
        echo "za <options>"
     echo -e "\nOptions:"
        echo "  -e, --edit      Edit source code"
        echo "  -h, --help      Display this help message"
        return
    }

    func() {
        #mpg123 ~/Downloads/za_warudo.mp3
        play ~/Downloads/za_warudo.mp3 -q -t alsa
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
