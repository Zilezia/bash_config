_flag() {
    local cur
    local opts opts_short
    local flags flags_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="      --edit --help"
    opts_short=" -e     -h"
    #flags="      --pol --tran"
    #flags_short=" -p    -t"

    COMPREPLY=(  $(compgen -W "${opts}"       -- ${cur}) )
    COMPREPLY+=( $(compgen -W "${opts_short}" -- ${cur}) )
    #COMPREPLY+=( $(compgen -W "${flags}"       -- ${cur}) )
    #COMPREPLY+=( $(compgen -W "${flags_short}" -- ${cur}) )

    return
}

flag() {
    help() {
        echo "flag <options>"
     echo -e "\nOptions:"
        echo "  -h, --help      Display this help message"
        return
    }

    local width=10
    local height=4

    space() {
        local num=""
        for i in $(seq 1 $width); do
            num="${num} "
        done
        echo "$num"
    }
    tall() {
        echo "a"
    }

    #horizontal() {}

    polska() {
        local pols=("${_WHITEB}$(space)${_CLR}" "${_REDB}$(space)${_CLR}")
        local num_colours=${#pols[@]}
        local num_stripes=$((height / num_colours))

        if (( height % num_stripes != 0)); then
            num_stripes=$((num_stripes + 1))
        fi

        local count=0
        for colour in "${pols[@]}"; do
            for ((i = 0; i < num_stripes; i++)); do
                if ((count >= height)); then break; fi
                echo -e "${colour}"
                count=$((count + 1))
            done
        done
    }

    for arg in "$@"; do
        case $arg in
            -h | --help)
                help;;
            -e | --edit)
                nano ${BASH_SOURCE[0]};;
            --width=*)
                width="${1#*=}"
                shift
                ;;
            -t | --tran)
                echo -e "\e[48;5;117m$(space)${_CLR}"
                echo -e "\e[48;5;218m$(space)${_CLR}"
                echo -e "${_WHITEB}$(space)${_CLR}"
                echo -e "\e[48;5;218m$(space)${_CLR}"
                echo -e "\e[48;5;117m$(space)${_CLR}"
                ;;
            -p | --pol)
                polska;;
        esac
    done
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then flag "$@"; fi
complete -F _flag flag
