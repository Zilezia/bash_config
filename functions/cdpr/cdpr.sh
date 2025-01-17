_cdpr() {
    local cur opts opts_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="      --edit --help"
    opts_short=" -e     -h"

    COMPREPLY=(  $(compgen -W "${opts}"       -- ${cur}) )
    COMPREPLY+=( $(compgen -W "${opts_short}" -- ${cur}) )
    return
}

cdpr() {
    help() {
        echo "cdpr <options>"
     echo -e "\ncd's to the project root dir"
     echo -e "\nOptions:"
        echo "  -e, --edit      Edit source code"
        echo "  -h, --help      Display this help message"
        return
    }

    fun() {
        local current_dir_path=$(pwd)
        IFS='/' read -ra curr_dir_arr <<< "$current_dir_path"
        local proj_name=${curr_dir_arr[4]} # proj_name: /home/{user}/{Documents}/HERE
        for proj_dir in $Kode/*; do
            if [[ -d $proj_dir ]]; then
                IFS='/' read -ra dirs <<< "$proj_dir"
                if [[ $proj_name == ${dirs[4]} ]]; then
                    cd "${proj_dir}"
                    return
                fi
            fi
        done
    }

    case $1 in
        -h | --help)
            help;;
        -e | --edit)
            nano ${BASH_SOURCE[0]};;
        *)
            func;;
    esac
    return
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then cdpr "$@"; fi
complete -F _cdpr cdpr
