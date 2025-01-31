# Bash functions
for func_path in $bafun/*; do
    if [[ -d $func_path ]]; then
        . $func_path/$(ls $func_path | grep .sh)
    fi
done
