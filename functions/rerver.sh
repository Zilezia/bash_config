# Just quicker setting up sites that are rust based
_rerver() {
    local cur prev commands server_opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    commands="--edit --help"
    commands_short="-e -h"
    server_opts="--activate --stop --serve --restart --log --help"
    server_opts_short="-a -s -S -r -l -h"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
        COMPREPLY+=( $(compgen -W "${commands_short}" -- ${cur}) )
    elif [[ ${COMP_CWORD} -eq 2 && ! ${prev} =~ ^- ]]; then
        COMPREPLY=( $(compgen -W "${server_opts}" -- ${cur}) )
        COMPREPLY+=( $(compgen -W "${server_opts_short}" -- ${cur}) )
    fi
    return
}

rerver() {
    # These helps are pretty pointless I'm literally making this function
    # solely for myself, I'm not intending to showing this to anyone
    # I'm literally talking to myself rn :skull:
    help() {
        echo 'rerver <command> <option>'
        echo
        echo 'Commands:'
     echo -e '              [server]    "Directory name of the server"          \e[1m[DEFAULT]\e[0m'
        echo '      -e      --edit      "Edit the function (using nano)"'
        echo '      -h      --help      "View this help message"'
        echo '      -H                  "View --log help message"'
        echo
        echo 'Options:'
        echo '      -a      --activate  "Get the server up and running"'
        echo '      -s      --stop      "Stop the server completely"'
        echo '      -S      --serve     "Serve the server (only for build)"'
        echo '      -r      --restart   "Restart the server"'
        echo '      -l      --log       "Show most recent logs"'
        echo '      -H                  "View --log help message"'
     echo -e '      -h      --help      "View this help message"                \e[1m[DEFAULT]\e[0m'
        return
    }

    log_help() {
        echo 'rerver [server] -l <option>'
        echo 'Options:'
        echo '      -c      --cat       "Cat the log file"'
     echo -e '      -t      --tail      "Show 10 lines from the bottom"         \e[1m[DEFAULT]\e[0m'
        echo '      -h      --help      "View this help message"'
        return
    }

    local pids cargo server front

    cleanup() {
        for pid in "${pids[@]}"; do
            kill -9 "${pid}"
        done
        echo
        echo "Cleaned everything up"
        return
    }

    activate_server() {
        if [ -f "$cargo" ]; then
            echo 'Activating server...'
            nohup cargo r --release --manifest-path $cargo > $server/server.log 2>&1 &
            echo $! > $server/server.pid
            echo 'Server is up!'
            return
        fi
    }

    stop_server() {
        stop_func() {
            echo 'Stopping server...'
            kill -9 $(cat $server/server.pid)
            echo 'Server stopped.'
        }

        if [ "$1" == 'r' ]; then
            stop_func
        else
            stop_func
            return
        fi
    }

    restart_server() {
        echo 'Restarting server...'
        stop_server 'r'
        activate_server
    }

    serve_server() {
        trap cleanup SIGINT SIGTERM

        echo 'Serving...'
        cargo r --manifest-path $cargo & pids+=( "$!" )
        trunk serve --config $front & pids+=( "$!" )
        wait

        trap - SIGINT SIGTERM
    }

    read_logs() {
        local log=$server/server.log
        case $1 in
            -c | --cat)
                cat $log;;
            -h | --help)
                log_help;;
            -t | --tail | *)
                tail -n10 $log;;
        esac
    }

    server_com() {
        local proj=$Kode/$1
        if [ ! -d "$proj" ]; then
            echo "There's no dir of that name."
            echo "Check for any typos."
            return
        fi
        cargo=$proj/Cargo.toml
        server=$proj/server
        front=$proj/front

        case $2 in
            -a | --activate)
                activate_server;;
            -s | --stop)
                stop_server;;
            -S | --serve)
                serve_server;;
            -r | --restart)
                restart_server;;
            -l | --log)
                read_logs $2;;
            -H)
                log_help;;
            -h | --help | *)
                help;;
        esac
    }

    case $1 in
        -e | --edit)
            nano $bafun/rerver.sh;;
        -h | --help)
            help;;
        -H)
            log_help;;
        *)
            if [ ${#1} -lt 5 ]; then help; fi
            server_com $1 $2
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then rerver "$@"; fi
complete -F _rerver rerver

