# TODO this
# 'Auto' create bash functions faster instead of writing them out yourself (like this)

nfunc() {
    help() {
        echo "nfunc <commands>"
        echo "Options:"
        echo "  -h, --help      Display this help message"
        echo "  -a              Does nothing"
    }
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then help; return 0; fi

    verb=0
    while getopts "a" opt; do
    case $opt in
        a) verb=1;;
    esac
    done
    echo "$verb"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then nfunc "$@"; fi
