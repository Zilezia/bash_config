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
        (mpg123 -q -n 100 ~/Downloads/za_warudo-stop_resume.mp3 &)
        #sleep 1

        local app_list='sleep|firefox|vivaldi|chrome|edge|vesktop|obs|vlc|blue' # should get my bluetooth???
        local procs=$(ps -u zilezia | grep -E "${app_list}" | awk '{print $1}')

        # stop optional app
        for proc in $procs; do kill -STOP "${proc}"; done

        local when_stop=$(date +'%d %b %Y %H:%M:%S')
        for i in {1..6}; do
            (s date --set="${when_stop}" &> /dev/null)
            sleep 1
        done
        # resume
        for proc in $procs; do kill -CONT "${proc}"; done

        #echo -e "\nRESUMED\n"
        (mpg123 -q -k 120 ~/Downloads/za_warudo-stop_resume.mp3 &)
        return
    }

    case $1 in
        warudo)
            (func &);;
        -z)
            #local all_procs=$(ps -u zilezia | awk '{print $ 1 }' | grep -E '[0-9]')
            local app_list='sleep|firefox|vivaldi|chrome|edge|vesktop|obs'
            local all_procs=$(ps -u zilezia | grep -E "${app_list}" | awk '{print $1}')
            for proc in $all_procs; do
                echo "${proc}"
            done
            ;;
        -e | --edit)
            nano ${BASH_SOURCE[0]};;
        -h | --help | *)
            help;;
    esac
    return
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then za "$@"; fi
complete -F _za za
