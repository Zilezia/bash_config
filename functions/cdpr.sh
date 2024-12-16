function cdpr() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "cdpr <commands>"
        echo "Options:"
        echo "  -h, --help      Display this help message"
        return
    fi

    local current_dir_path=$(pwd)
    IFS='/' read -ra curr_dir_arr <<< "$current_dir_path"
    local proj_name="${curr_dir_arr[4]}"
    for proj_dir in ~/Kode/*; do
        if [ -d "$proj_dir" ]; then
            IFS='/' read -ra dirs <<< "$proj_dir"
            if [[ "$proj_name" == "${dirs[4]}" ]]; then
                cd "$proj_dir"
                return
            fi
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then cdpr "$@"; fi
