# Print out exactly what mv will do when run

mvsim() {
    if [ $# -lt 2 ]; then
        echo "Too few arguments given; at least 2 arguments are needed."
        return 1
    fi

    lastArg="${@:$#}"

    i=1
    for param in "$@"; do
        if [ ! -e "$param" -a $i -lt $# ]; then
            echo "Error: $param does not exist."
            return 1
        elif [ "$param" = "$lastArg" -a $i -lt $# ]; then
            echo "Error: $param is the same file/directory as the destination."
            return 1
        fi
        ((i++))
    done

    if [ $# -eq 2 ]; then # special case for 2 arguments to make output look better
        if [ -d "$1" ]; then
            if [ -d "$2" ]; then
                echo "Moves directory $1 (and anything inside it) into directory $2"
                return 0
            elif [ ! -e "$2" ]; then
                echo "Renames directory $1 to $2"
                return 0
            else
                echo "Error: $2 is not a directory; mv cannot overwrite a non-directory with a directory."
                return 1
            fi
        else
            if [ -d "$2" ]; then
                echo "Moves file $1 into directory $2"
            elif [ -e "$2" ]; then
                echo "Renames file $1 to $2, replacing file $2"
            else
                echo "Renames file $1 to $2"
            fi
            return 0
        fi
    elif [ ! -e "$lastArg" ]; then
        echo "Error: $lastArg does not exist."
        return 1
    elif [ ! -d "$lastArg" ]; then
        echo "Error: $lastArg is not a directory; mv cannot merge multiple files into one."
        return 1
    fi

    argsLeft=$#
    echo "Moves..."
    for param in  "$@"; do
        if [ $argsLeft -eq 1 ]; then
            echo "...Into the directory $param" # has to be a directory because -f $lastArg was dealt with earlier
            return 0
        fi
        if [ -d "$param" ]; then
            if [ ! -d "$lastArg" ]; then
                echo "Error: $lastArg is not a directory; mv cannot overwrite a non-directory with a directory."
                return 1
            fi
            if [ $argsLeft -eq $# ]; then
                echo "The directory ${param} (and anything inside it)..."
            else
                echo "And the directory ${param} (and anything inside it)..."
            fi
        else
            if [ $argsLeft -eq $# ]; then
                echo "The file ${param}..."
            else
                echo "And the file ${param}..."
            fi
        fi
        ((argsLeft--))
    done
}

# Examples:

# $ ls
# dir1  dir2  file1  file2  file3  mvsim
# $ ./mvsim file1 file2
# Renames file file1 to file2, replacing file file2
# $ ./mvsim file1 newfile
# Renames file file1 to newfile
# $ ./mvsim file1 dir1
# Moves file file1 into the directory dir1
# $ ./mvsim file1 file2 file3 dir1
# Moves...
# The file file1...
# And the file file2...
# And the file file3...
# ...Into the directory dir1
# $ ./mvsim file1 file2 dir1 dir2
# Moves...
# The file file1...
# And the file file2...
# And the directory dir1 (and anything inside it)...
# ...Into the directory dir2
# $ ./mvsim file1 file2 file3 # error - file3 isn't a directory
# Error: file3 is not a directory; mv cannot merge multiple files into one.
# $ ./mvsim -f -i file1 dir1 # options aren't parsed or filtered out
# Error: -f does not exist.