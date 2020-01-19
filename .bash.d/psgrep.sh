# Quick way to search for running scripts/apps
psgrep() {
    echo "ps -aux:"
    ps -aux | grep $1
    echo ""
    echo "top:"
    top -b -n 1 | grep $1
}
