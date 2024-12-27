# Just quicker setting up sites that are rust based

rerver() {
    # These helps are pretty pointless I'm literally making this function
    # solely for myself, I'm not intending to showing this to anyone
    # I'm literally talking to myself rn :skull:
    local underline=`tput smul`
    local nounderline=`tput rmul`
    local bold=`tput bold`
    local normal=`tput sgr0`
    help() {
        echo 'rerver <command> <option>'
        echo
        echo 'Commands:'
        echo "  [server]            \"Directory name of the server\"          ${bold}[DEFAULT]"
        echo '  -e      --edit      "Edit the function (using nano)"'
        echo '  -h      --help      "View this help message"'
        echo '  -H                  "View --log help message"\n'
        echo 'Options:'
        echo '  -a      --activate  "Get the server up and running"'
        echo '  -s      --stop      "Stop the server completely"'
        echo '  -S      --serve     "Serve the server (only for build)"'
        echo '  -r      --restart   "Restart the server"'
        echo '  -l      --log       "Show most recent logs"'
        echo '  -H                  "View --log help message"'
        echo '  -h      --help      "View this help message"                [DEFAULT]'
        return
    }

    log_help() {
        echo 'rerver [server] -l <option>'
        echo 'Options:'
        echo '  -c      --cat       "Cat the log file"'
        echo '  -t      --tail      "Show 10 lines from the bottom"         [DEFAULT]'
        echo '  -h      --help      "View this help message"'
        return
    }

    cleanup() {
        pkill -P $$
        echo 'Processes killed.'
    }

    local cargo
    local server
    local front

    activate_server() {
        if [ -f "$cargo" ]; then
            if [ ! -d "$server"]; then mkdir $server; fi
            echo 'Activating server...'
            nohup cargo r --release --manifest-path $cargo > $server/server.log 2>&1 &
            echo $! > $server/server.pid
            echo 'Server is up!'
            return
        fi
    }

    stop_server() {
        echo 'Stopping server...'
        kill -9 $(cat $server/server.pid)
    }

    restart_server() {
        echo 'Restarting server...'
        stop_server
        activate_server
    }

    serve_server() {
        trap cleanup SIGINT SIGTERM

        echo 'Serving...'
        cargo r --manifest-path $cargo &
        trunk serve --config $front &
        wait
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
