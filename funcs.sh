# Bash functions
for file in ~/.bash/functions/*; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done
