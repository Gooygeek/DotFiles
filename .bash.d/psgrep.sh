# Get the currently activated virtual environment. Used in PS1
__py_venv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    printf "<%s>" "${VIRTUAL_ENV##*/}"
  fi
}
