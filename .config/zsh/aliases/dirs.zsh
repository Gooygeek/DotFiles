
# List dir with:
# 	- Almost all
# 	- Colour
# 	- Filetype
# 	- Horizonal
alias ls='ls -AF --format=horizontal --color=auto'

# List dir with:
# 	- Long format
# 	- Almost all
# 	- Sorted by time (recents at the bottom)
# 	- Human readable filesize
# 	- Nicer timestamp
alias lls='ls -AFltrh --time-style long-iso --color=auto'
alias ll='lls'

# Create all parent directories too
alias mkdir='mkdir -p'
