# 'Auto' create bash aliases

nalias() {

    help() {
        echo "nalias <commands>"
        echo "Options:"
        echo "  -h, --help      Display this help message"
        echo "  -a              Does nothing"
    }
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then help; return 0; fi

    while getopts "a" opt; do
        case $opt in
            a)
                echo "a"
                return 0;;
            *)
                echo "$1 is not recognised"
                return 0;;
        esac
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then nalias "$@"; fi
