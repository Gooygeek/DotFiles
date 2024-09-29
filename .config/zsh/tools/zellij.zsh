# Create the my 'main' zj session or attach to it if it already exists

function zjm() {
    zj -l main -s main
    if [ $? -ne 0 ]; then
        zj a main
    fi
}


# Delete and recreate main
function zjrm() {
    zj -d main
    zj -l main -s main
}

