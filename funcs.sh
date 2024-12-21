# Bash functions
for file in $bafun/*; do
    if [ -f "$file" ]; then . "$file"; fi
done
