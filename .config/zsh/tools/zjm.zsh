# Create the my 'main' zj session or attach to it if it already exists

function zjm() {
    zj -l main -s main
    if [ $? -ne 0 ]; then
        zj a main
    fi
}
