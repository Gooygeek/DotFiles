# Bash bookmark manager, credit goes to getmizanur at Stackoverflow
bookmark_manager() {
    bookmark_storage="${HOME}/.bookmarks"
    USAGE="Usage: bm [-c|-g|-d|-l] [bookmark]
      -c | --create <bookmark>
        Bookmark the current directory under <bookmark>
      -g | --go <bookmark>
        Go to the directory saved under <boomark>
      -d | --delete <boomark>
        Delete directory under <bookmark>
      -l | --list
        List all the saved bookmarks
      Anything else shows this help text
    " ;
    if  [ ! -e ${bookmark_storage} ] ; then
        mkdir ${bookmark_storage}
    fi
    case $1 in
        # create bookmark
        -c | --create) shift
            if [ ! -f ${bookmark_storage}/$1 ] ; then
                echo "$(pwd)" > ${bookmark_storage}/"$1" ;
            else
                echo "Try again! Looks like there is already a bookmark '$1'"
            fi
            ;;
        # goto bookmark
        -g | --go) shift
            if [ -f ${bookmark_storage}/${1} ] ; then
                cd $(cat ${bookmark_storage}/${1})
            else
                echo "Mmm...looks like your bookmark has spontaneously combusted. What I mean to say is that your bookmark does not exist."
            fi
            ;;
        # delete bookmark
        -d | --delete) shift
            if [ -f ${bookmark_storage}/$1 ] ; then
                rm ${bookmark_storage}/"$1" ;
            else
                echo "Oops, forgot to specify the bookmark" ;
            fi
            ;;
        # list bookmarks
        -l | --list) shift
            for bookmark in ${bookmark_storage}/*
            do
                echo  "$(basename ${bookmark}) -> $(cat ${bookmark})" ;
            done
            ;;
         *) echo "$USAGE" ;
            ;;
    esac
}

alias bm='bookmark_manager'