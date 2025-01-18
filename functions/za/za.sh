_za() {
    local cur
    local stands
    local opts opts_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    stands="warudo hando"
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

    warudo_func() {
        warudo
        sleep 1

        local app_list='sleep|firefox|vivaldi|chrome|edge|vesktop|obs|vlc|blue|steam'
        local procs=$(ps -u zilezia | grep -E "${app_list}" | awk '{print $1}')

        # stop optional app
        for proc in $procs; do kill -STOP "${proc}"; done

        local when_stop=$(date +'%d %b %Y %H:%M:%S')
        for i in {1..6}; do
            # i dont like this part i need sudo to change the date
            (s date --set="${when_stop}" &> /dev/null)
            sleep 1
        done
        # resume
        for proc in $procs; do kill -CONT "${proc}"; done

        #echo -e "\nRESUMED\n"
        (mpg123 -q -k 120 ~/Downloads/za_warudo-stop_resume.mp3 &)
        return
    }

    hando_func() {
        hando
        local proc=$(ps -u zilezia | grep -E "${1}" | awk '{print $1}')
        if [[ ${#proc} -gt 0 ]]; then
            kill -9 $proc
        fi
        return
    }

    case $1 in
        warudo)
            (warudo_func &);;
        hando)
            (hando_func $2 &);;
        -e | --edit)
            nano ${BASH_SOURCE[0]};;
        -h | --help | *)
            help;;
    esac
    return
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then za "$@"; fi
complete -F _za za
