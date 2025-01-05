# Just quicker setting up sites that are rust based
_rerver() {
    local cur prev commands server_opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    commands="      --edit --help"
    commands_short="-e     -h"
    server_opts="      --activate --stop --serve --restart --log --help"
    server_opts_short="-a         -s     -S      -r        -l    -h"

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
     echo -e '              [server]    "Directory name of the server"          \e[1m[DEFAULT]\e[0m'
        echo '      -e      --edit      "Edit the function (using nano)"'
        echo '      -h      --help      "View this help message"'
        echo '      -H                  "View --log help message"'
     echo -e '\nOptions:'
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
     echo -e '\nOptions:'
        echo '      -c      --cat       "Cat the log file"'
     echo -e '      -t      --tail      "Show 10 lines from the bottom"         \e[1m[DEFAULT]\e[0m'
        echo '      -h      --help      "View this help message"'
        return
    }

    local pids # more used for serving than real shit
    local cargo front
    local server logs # tryna get better logging, atm they just get overriden with new ones

    local log_amount=0
    # cant do with ^ icba figuring out to be ignoring the prior path and just doing the name
    local LOG_REGEX='^server_20[0-9]{2}-[0-9]{1,2}-[0-9]{1,2}_[0-9]+.log$'

    local curr_date_dir="`date "+%Y_%m_%d"`"
    local curr_date="`date "+%Y-%m-%d"`"

    # ${string:5:1} # gets 5th character
    # ${string:5:2} # gets 2 characters from 5th position

    curr_log() {
        local curr_log
        for log in $logs/*; do
            if [[ ( -f $log ) && ( $log == *.log ) ]]; then
                curr_log=$log
                break
            fi
        done
        echo "${curr_log}"
    }

    new_log() {
        local nlog_num
        for date_dir in $logs/*; do
            if [[ ( -d $date_dir ) && ( $date_dir == $logs/$curr_date_dir ) ]]; then
                for logp in $date_dir/*; do
                    if [[ ( -f $logp ) && ( $logp == *.log ) ]]; then
                        IFS='/' read -ra log_split <<< "$logp"
                        local log=${log_split[-1]}    # this just gets the file without the path
                        local end_log=${log##*_}      # n.log
                        local log_num=${end_log%.log} # n
                        nlog_num=log_num
                    fi
                done
                break
            fi
        done
        let "nlog_num++" # n + 1
        local nlog=server_"${curr_date}"_"${nlog_num}".log
        echo "$logs/$nlog"
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
                echo "${use_log}"
                echo 'Activating server...'
                nohup cargo r --release --manifest-path $cargo > $(new_log) 2>&1 &
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
            # moving the log into its date dir
            if [[ -f $(curr_log) ]]; then
                mv $(curr_log) $logs/$curr_date_dir
            fi
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
        trap cleanup SIGINT SIGTERM

        echo 'Serving...'
        cargo r --manifest-path $cargo & pids+=( "$!" )
        trunk serve --config $front & pids+=( "$!" )
        wait

        trap - SIGINT SIGTERM
    }

    read_logs() {
        local def_log=$(curr_log)
        if [[ ! -f $def_log ]]; then
            for log in $logs/$curr_date_dir/*; do
                def_log=$log
            done
        fi
        case $1 in
            -c | --cat)
                cat $def_log;;
            -h | --help)
                log_help;;
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
            # this does if first option "rerver <option>" is shorter than 5 characters it'll show the help message
            if [[ ${#1} -lt 5 ]]; then
                help
            else
                server_com $1 $2
            fi;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then rerver "$@"; fi
complete -F _rerver rerver

