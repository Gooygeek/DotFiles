
# fzf keybindings and auto-completion
if command -v fzf >/dev/null 2>&1; then
  if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
  else
    echo "fzf keybindings and auto-completion not found"
  fi
fi


if command -v fzf >/dev/null 2>&1; then
  # Display at the top of the screen
  # Toggle preview window visibility with '?' with shift up/down to scroll the preview
  # Select all entries with 'CTRL-A'
  # Copy the selected entries to the clipboard with 'CTRL-Y'
  # Open the selected entries in vim with 'CTRL-E'
  # Open the selected entries in vscode with 'CTRL-V'
  export FZF_DEFAULT_OPTS="
    --layout=reverse
    --info=inline
    --height=70%
    --prompt='∼ ' --pointer='▶'
    --color='hl:148,hl+:154,pointer:#a1efe4,marker:010,bg+:#383830,bg:#272822'

    --multi --marker='✓'

    --preview-window=:hidden
    --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'

    --bind '?:toggle-preview,shift-up:preview-up,shift-down:preview-down'
    --bind 'ctrl-a:select-all'
    --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    --bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
    --bind 'ctrl-v:execute(code {+})'
    "
fi

# If fd is installed, use that over the find command
if command -v fd >/dev/null 2>&1; then
  # Show hidden files, follow links
  export FZF_DEFAULT_COMMAND="fd"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
  _fzf_compgen_path() {
      fd . "$1"
  }
  _fzf_compgen_dir() {
      fd --type d . "$1"
  }
fi
