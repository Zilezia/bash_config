#!/bin/sh
# Just quicker setting up sites that are rust based
_rerver() {
    local cur prev
    local commands       server_opts
    local commands_short server_opts_short
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    commands="      --edit --help"
    commands_short=" -e     -h"
    server_opts="      --activate --stop --serve --restart --log --help"
    server_opts_short=" -a         -s     -S      -r        -l    -h"

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
    help() {
        echo 'rerver <command> <option>'
     echo -e '\nCommands:'
     echo -e '              [server]    "Directory name of the server"          \[\e[1m\][DEFAULT]\[\e[0m\]'
        echo '      -e      --edit      "Edit the function (using nano)"'
        echo '      -h      --help      "View this help message"'
        echo '      -H                  "View --log help message"'
        echo '      -S      --serve     "Serve the current directory (only for build)"'
     echo -e '\nOptions:'
        echo '      -a      --activate  "Get the server up and running"'
        echo '      -s      --stop      "Stop the server completely"'
        echo '      -S      --serve     "Serve the server (only for build)"'
        echo '      -r      --restart   "Restart the server"'
        echo '      -l      --log       "Show most recent logs"'
        echo '      -H                  "View --log help message"'
     echo -e '      -h      --help      "View this help message"                \[\e[1m\][DEFAULT]\[\e[0m\]'
        return
    }

    log_help() {
        echo 'rerver [server] -l <option>'
     echo -e '\nOptions:'
        echo '      -c      --cat       "Cat the log file"'
     echo -e '      -t      --tail      "Show 10 lines from the bottom"         \[\e[1m\][DEFAULT]\[\e[0m\]'
        echo '      -h      --help      "View this help message"'
        return
    }

    local pids # more used for serving than real shit
    local cargo front
    local server logs # tryna get better logging, atm they just get overriden with new ones

    local log_amount=0
    # cant do with ^ icba figuring out to be ignoring the prior path and just doing the name
    local LOG_REGEX='^server_20[0-9]{2}-[0-9]{1,2}-[0-9]{1,2}_[0-9]+.log$'

    local curr_date_dir=$(date "+%Y_%m_%d")
    local curr_date=$(date "+%Y-%m-%d")

    # ${string:5:1} # gets 5th character
    # ${string:5:2} # gets 2 characters from 5th position
    latest_log() { # it works at least idc
        local latest_dir=$(ls $logs -Art | tail -n 1)
        local latest_log=$(ls $logs/$latest_dir -Art | tail -n 1)
        local log_path="${logs}/${latest_dir}/${latest_log}"
        echo "${log_path}"
    }

    new_log() {
        local curr_path="${logs}/${curr_date_dir}"
        local nlog_num=0

        if [[ -d $curr_path ]]; then
            for log_file in $curr_path/*.log; do
                if [[ -f $log_file ]]; then
                    local log_name=$(basename "$log_file")
                    local log_num=${log_name##*_}
                    log_num=${log_num%.log}
                    if [[ $log_num -gt $nlog_num ]]; then
                        nlog_num=$log_num
                    fi
                fi
            done
        else
            mkdir -p "$curr_path"
        fi
        nlog_num=$((nlog_num + 1))
        local nlog="server_${curr_date}_${nlog_num}.log"
        local log_path="${curr_path}/${nlog}"
        touch "$log_path"
        echo "$log_path"
    }

    cleanup() {
        for pid in "${pids[@]}"; do
            kill -9 "${pid}"
        done
        echo -e "\nCleaned everything up"
        return
    }

    activate_server() {
        if [[ -f $cargo ]]; then
            if [[ -d $server ]]; then
                echo 'Activating server...'
                # build front meanwhile
                trunk build --config $front --release
                nohup cargo r --release --manifest-path "$cargo" > "$(new_log)" 2>&1 &
                echo $! > $server/server.pid
                echo 'Server is up!'
                return
            else
                echo "Server dir doesn't exist"
                return
            fi
        else
            echo "Are you sure this is a rust server?"
            return
        fi
    }

    stop_server() {
        stop_func() {
            echo 'Stopping server...'
            kill -9 $(cat $server/server.pid)
            echo 'Server stopped.'
        }
        # here it will decide to just stop (restarting) the server or completely stop itself
        if [[ $1 == 'r' ]]; then
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
        # use my cleanup for this when ^C
        trap cleanup SIGINT SIGTERM
        if [[ $1 == '-r' ]]; then
            echo 'Serving as release...'
            cargo r --manifest-path $cargo --release & pids+=( "$!" )
            trunk serve --config $front --release & pids+=( "$!" )
        else
            echo 'Serving...'
            cargo r --manifest-path $cargo & pids+=( "$!" )
            trunk serve --config $front & pids+=( "$!" )
        fi
        wait
        # default ^C cuz it'll still do cleanup when I ^C
        trap - SIGINT SIGTERM
    }
    # TODO forgot this
    read_logs() {
        local def_log=$(latest_log)

        case $1 in
            -h | --help)
                log_help;;
            -c | --cat)
                cat $def_log;;
            -m | --more)
                more $def_log;;
            -t | --tail | *)
                tail -n10 $def_log;;
        esac
    }

    server_com() {
        local proj=$Kode/$1
        if [[ ! -d $proj ]]; then
            echo "There's no directory of that name."
            echo "Check for any typos."
            return
        fi
        # these by default are expected and already created
        cargo=$proj/Cargo.toml
        front=$proj/front
        # these are entirely just used by this function
        server=$proj/server
        logs=$server/logs
        if [[ ! -d $server ]]; then mkdir $server; fi
        if [[ ! -d $logs ]]; then mkdir $logs; fi

        case $2 in
            --cl)
                new_log;;
            -a | --activate)
                activate_server;;
            -s | --stop)
                stop_server;;
            -S | --serve)
                serve_server $3;;
            -r | --restart)
                restart_server;;
            -l | --log)
                read_logs $3;;
            -H)
                log_help;;
            -h | --help | *)
                help;;
        esac
    }

    local curr=${PWD##*/}
    curr=${curr:-/}

    case $1 in
        -e | --edit)
            micro ${BASH_SOURCE[0]};;
        -h | --help)
            help;;
        -H)
            log_help;;
        -S)
            server_com $curr -S $2;;
        -a | --activate)
            server_com $curr -a;;
        -s | --stop)
            server_com $curr -s;;
        -r | --restart)
            server_com $curr -r;;
        -l | --log)
            server_com $curr -l $2;;
        *) # path/dir specific
            if [[ ${#1} -gt 5 ]]; then
                server_com $1 $2
            else
                help
            fi;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then rerver "$@"; fi
complete -F _rerver rerver
