
# fzf keybindings and auto-completion
if command -v fzf >/dev/null 2>&1; then
  if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
  else
    echo "fzf keybindings and auto-completion not found"
  fi
fi
