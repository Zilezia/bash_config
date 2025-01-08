_mrepo() {
    local cur opts opts_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="      --edit --help"
    opts_short=" -e     -h"

    COMPREPLY=(  $(compgen -W "${opts}"       -- ${cur}) )
    COMPREPLY+=( $(compgen -W "${opts_short}" -- ${cur}) )
    return
}

mrepo() {
    help() {
        echo "mrepo <options>"
     echo -e "\ncd's to the project root dir"
     echo -e "\nOptions:"
        echo "  -h, --help      Display this help message"
        return
    }

    case $1 in
        -h | --help)
            help;;
        -e | --edit)
            nano ${BASH_SOURCE[0]};;
    esac

    local repo1=$(git remote get-url origin)
    local repo2=${repo1#ssh://git@}
    local url=${repo2//[:]//}

    $browser $url
    return
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then mrepo "$@"; fi
complete -F _mrepo mrepo
