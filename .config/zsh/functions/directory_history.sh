
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

# List directory navigation history with numbers
# This makes it easy to enter a number in bd to go back to that dir
alias dh='dirs -v'
