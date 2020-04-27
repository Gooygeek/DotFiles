

# Keep a history of the directories navigated to
changedir() {
  if [ "$#" = "0" ]; then  # If bare, cd to home
    changedir $HOME
  elif [ "$(pwd)" = "${1}" ] || [ "$(pwd)/" = "${1}" ]; then  # If cd to current dir, then do nothing.  The second condition is because paths can optionaly end in /
    :
  elif [ -f "${1}" ]; then  # If cd to a file, then open in editor
    ${EDITOR} ${1}
  else  # If not bare and path is a folder not currently in, cd to it
    pushd "$1" > /dev/null
  fi
}

alias cd='changedir'


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
