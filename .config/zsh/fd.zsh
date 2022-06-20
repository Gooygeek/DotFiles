
if command -v fd >/dev/null 2>&1; then
  # fd and find take different arguments, this can break scripting.
  # alias find='fd'
  fd_default_command_options="--hidden --follow --ignore-file ~/.config/fd/ignore"
  alias fd="fd $fd_default_command_options"
fi
