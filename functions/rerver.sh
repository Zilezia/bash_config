rerver() {
    # These helps are pretty pointless I'm literally making this function
    # solely for myself, I'm not intending to showing this to anyone
    # I'm literally talking to myself rn :skull:
    help() {
        echo 'rerver <server> <command>'
        echo 'Options:'
        echo '  -a      --activate  "Get the server up and running"'
        echo '  -s      --stop      "Stop the server completely"'
        echo '  -S      --serve     "Serve the server (only for build)"'
        echo '  -r      --restart   "Restart the server"'
        echo '  -l      --log       "Show most recent logs"'
        echo '  -e      --edit      "Edit the function (using nano)"'
        echo '  -H                  "View --log help message"'
        echo '  -h      --help      "View this help message"                [DEFAULT]'
        return
    }

    log_help() {
        echo 'rerver <server> -l [option]'
        echo 'Options:'
        echo '  -c      --cat       "Cat the log file"'
        echo '  -t      --tail      "Show 10 lines from the bottom"     [DEFAULT]'
        echo '  -h      --help      "View this help message"'
        return
    }

    cleanup() {
        pkill -P $$
        echo 'end of serve'
    }

    local cargo
    local server
    local front

    activate_server() {
        if [ -f "$path" ]; then
            if [ ! -d "$server"]; then mkdir $server; fi
            nohup cargo r --release --manifest-path $cargo > $server/server.log 2>&1 &
            echo $! > $server/server.pid
            echo 'Server is up!'
            return
        fi
    }

    serve_server() {
        trap cleanup SIGINT SIGTERM
        echo 'serving'
        cargo r --manifest-path $cargo &
        trunk serve --config $front &
        wait
    }

    read_logs() {
        echo "$server"
        cat $cargo
    }

    server_com() {
        cargo=$Kode/$1/Cargo.toml
        server=$Kode/$1/server
        front=$Kode/$1/front

        case $2 in
            -a | --activate)
                activate_server $1;;
            -s | --stop)
                stop_server $1;;
            -S | --serve)
                serve_server $1;;
            -r | --restart)
                restart_server $1;;
            -l | --log)
                read_logs $1 $2;;
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
