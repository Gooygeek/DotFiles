
zmodload zsh/complist
zstyle ':completion:*:complete:*' list-colors "$LS_COLORS" # Set colours for zsh completions
zstyle ':completion:*' menu select # Use menu selection
zstyle ':completion:*' select-prompt "--vvvvv--" # Used to indicate when there are options that don't fit on the screen
