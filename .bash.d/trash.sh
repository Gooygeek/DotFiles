

# Assumes file names or folders don't contain ':' else it cannot be restored


if [ ! -d "$HOME/.trash" ]; then
    mkdir $HOME/.trash
    touch $HOME/.trash/.TRASHDB
fi

move_to_trash() {
    mv $1 $HOME/.trash
    echo "\"$1\":$(pwd)" >> $HOME/.trash/.TRASHDB
}

restore_file() {
    restore_location=`cat $HOME/.trash/.TRASHDB | grep "$1" | cut --delimiter=":" --fields=2`
    mv $1 $restore_location
    sed "/$1/d" $HOME/.trash/.TRASHDB
}

alias del='move_to_trash'
alias restore='restore_file'
