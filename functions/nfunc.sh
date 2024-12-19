# TODO this
# 'Auto' create bash functions faster instead of writing them out yourself (like this)

nfunc() {
    help() {
        echo "nfunc - Create new bash function"
        echo "Options:"
        echo "  -h, --help      Display this help message"
        return
    }
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then help; return 0; fi

    local file=${1%.*}
    local file_name="$file.sh"
    local file_path="$bash/functions/$file_name"
    return
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then nfunc "$@"; fi
