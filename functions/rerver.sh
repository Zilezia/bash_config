zilezia() {
    # These helps are pretty pointless I'm literally making this function
    # solely for myself, I'm not intending to showing this to anyone
    # I'm literally talking to myself rn :skull:
    help() {
        echo 'zilezia <command> [option]'
        echo 'Options:'
        echo '  -s      --start     "Get the server up and running"'
        echo '  -S      --stop      "Stop the server completely"'
        echo '  -r      --restart   "Restart the server"'
        echo '  -l      --log       "Show most recent logs"'
        echo '  -p      --ping      "Ping the server to check if its up"'
        echo '  -e      --edit      "Edit the function (using nano)"'
        echo '  -H                  "View --log help message"'
        echo '  -h      --help      "View this help message"                [DEFAULT]'
        return
    }

    log_help() {
        echo 'zilezia -l [option]'
        echo 'Options:'
        echo '  -c      --cat       "Cat the log file"'
        echo '  -t      --tail      "Show 10 lines from the bottom"     [DEFAULT]'
        echo '  -h      --help      "View this help message"'
        return
    }

    local server=$zilezia/server

    start_server() {
        nohup cargo r --release --manifest-path $zilezia/Cargo.toml > $server/server.log 2>&1 &
        echo $! > $server/server.pid
        echo "Server Started"
    }

    stop_server() {
        echo "Stopping server"
        kill -9 $(cat $server/server.pid)
    }

    restart_server() {
        echo "Restarting server"
        stop_server
        start_server
    }

    read_logs() {
        local log=$server/server.log
        case "$1" in
            -c | --cat)
                cat $log;;
            -h | --help)
                log_help;;
            -t | --tail | *)
                tail -n10 $log;;
        esac
    }

    case $1 in
        -s | --start)
            start_server;;
        -S | --stop)
            stop_server;;
        -r | --restart)
            restart_server;;
        -l | --log)
            read_logs $2;;
        -e | --edit)
            nano $bafun/zilezia.sh;;
        -p | --ping)
            ping zilezia.dev;;
        -H)
            log_help;;
        -h | --help | *)
            help;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then zilezia "$@"; fi
