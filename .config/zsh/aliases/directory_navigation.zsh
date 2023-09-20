
# Use fzf to search for a previous directory and cd to it.
alias dh="pushd \"\$(dirs -v | cut -d$'\t' -f2 | fzf | sed 's#~#$HOME#')\""

# List dir with:
# 	- Almost all
# 	- Colour
# 	- Filetype
# 	- Horizonal
if [ $machine = "Mac" ]; then
    alias ls='ls -AF --color=auto'
else
    alias ls='ls -AF --format=horizontal --color=auto'
fi

# List dir with:
# 	- Long format
# 	- Almost all
# 	- Sorted by time (recents at the bottom)
# 	- Human readable filesize
# 	- Nicer timestamp
if [ $machine = "Mac" ]; then
    alias lls='ls -AFltrh --color=auto'
else
    alias lls='ls -AFltrh --time-style long-iso --color=auto'
fi
alias ll='lls'

# Create all parent directories too
alias mkdir='mkdir -p'
