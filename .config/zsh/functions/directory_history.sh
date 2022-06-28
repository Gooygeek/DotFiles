
# Go back to the previous directory in the nav history.
# Can also accept a number and will go back that many times
backdir() {
  if [ "$#" = "0" ]; then
    popd > /dev/null
  else
    for i in $(seq ${1}); do
      popd > /dev/null
    done
  fi
}

alias bd='backdir'
