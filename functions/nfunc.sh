# TODO still doing this, but initialising works

# 'Auto' create bash functions faster instead of writing them out yourself (like this)

nfunc() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "nfunc - Create new bash function"
        echo "Options:"
        return
    fi

    # check maybe if the function already exists?

    local func_name=${1%.*}
    local file_name="$func_name.sh"
    local file_path="$bash/functions/$file_name"

    local func_desc="n/a"

cat > "$file_path" << EOF
$func_name() {
    help() {
        echo "$func_name - $func_desc"
        echo "Options:"
        return
    }
    if [ "\$1" = "-h" ] || [ "\$1" = "--help" ]; then help; return 0; fi

    echo "test func used!"
    return
}

if [[ "\${BASH_SOURCE[0]}" == "\${0}" ]]; then $func_name "\$@"; fi
EOF

    reload
    nano "$file_path"
    return
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then nfunc "$@"; fi
