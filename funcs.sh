# Bash functions
for file in $bafun/*; do
    if [[( -f $file ) && ( $file == *.sh )]]; then
        . $file
    fi
done
