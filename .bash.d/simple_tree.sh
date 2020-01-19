# Replacement for when 'tree' is not installed
# The 'find' command can also be used and replaces everything upto and including the first sed operation
simple_tree() {
    HORIZONTAL_CHAR="--";
        ls -AF --format=horizontal --color=auto -AR $1 | grep --color=auto ":$" | sed -e 's/:$//' -e "s/[^-][^\/]*\//$HORIZONTAL_CHAR/g" -e "s/^/ /     " -e "s/-/|/"
}

# An alternative using 'find' instead of ls.
# This version can be customised to include only showing dirs, a resursion depth and other things the 'find' command can do
#function simple_tree() {
#    HORIZONTAL_CHAR="--"
#    find $1 | sed  -e "s/[^-][^\/]*\//$HORIZONTAL_CHAR/g" -e "s/^/ /" -e "s/-/|/"
#}
