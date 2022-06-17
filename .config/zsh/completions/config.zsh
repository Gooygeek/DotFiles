
zmodload zsh/complist
zstyle ':completion:*:complete:*' list-colors "$LS_COLORS" # Set colours for zsh completions
zstyle ':completion:*' menu select # Use menu selection
zstyle ':completion:*' select-prompt "--vvvvv--" # Used to indicate when there are options that don't fit on the screen
zstyle ':completion::complete:*' use-cache 1 # Enable completion cache
zstyle ':completion::complete:*' cache-path ~/.config/zsh/completion.cache
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f' # Print descriptions for 'types'
zstyle ':completion:*' group-name '' # Group 'types'
zstyle ':completion:*' squeeze-slashes true # convert `//`` to `/` instead of the default `/*/` as it's more cross compatible