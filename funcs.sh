# Bash functions
for func_path in $bafun/*; do
    . $func_path/$(ls $func_path | grep .sh)
done
