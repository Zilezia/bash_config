# 'Auto' create bash aliases

nalias() {
    help() {
        echo "nalias <options>"
     echo -e "\nOptions:"
        echo "  -h, --help      Display this help message"
        return
    }
    case $1 in
        -e | --edit)
            nano ${BASH_SOURCE[0]};;
        -h | --help | *)
            help;;
    esac

    alias_name=''
    alias_func=''
    line_write=28
    # i tbh got no clue what is going on here this is my first function i did in bash
     while getopts ":n:f:L::" opt; do
        echo "Proc opt: $opt, OPTARG: $OPTARG"
        case $opt in
            n)
                if [ -n "$OPTARG" ]; then
                    echo "$OPTARG"
                    alias_name="$OPTARG"
                else
                    echo "Error: Option -n requires an argument."
                    return -1
                fi;;
            f)
                if [ -n "$OPTARG" ]; then
                    echo "$OPTARG"
                    alias_func="$OPTARG"
                else
                    echo "Error: Option -f requires an argument."
                    return -1
                fi;;
            L)
                if [ -n "$OPTARG" ]; then
                    echo "$OPTARG"
                    line_write="$OPTARG"
                fi;;
            \?)
                echo "Invalid option: -$OPTARG"
                return -1;;
            *)
                echo "Option: -$OPTARG requires an argument."
                return -1;;
        esac
    done
    echo "name: $alias_name, func: $alias_func, line: $line_write"
   #if [ -z "$alias_name" ] || [ -z "$alias_func" ]; then
   #    echo "Empty"
   #    alias_name=''
   #    alias_func=''
   #    return 0
   #fi

    text_write="alias $alias_name='$alias_func'"
    #sed -i "${line_write}i\\$text_write" ~/.bash/aliases.sh

    #reload
    echo "$text_write"
    return 1
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then nalias "$@"; fi
