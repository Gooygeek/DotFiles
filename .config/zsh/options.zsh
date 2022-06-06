
## Changing Directories

# Automatically use pushd when calling cd
setopt AUTO_PUSHD
# Don't push multiple copies of the same directory onto the directory stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd
setopt PUSHD_SILENT

## Completion

# Allow completions to work for aliases
unsetopt COMPLETE_ALIASES

## Expansion and Globbing

## History

# If the internal history needs to be trimmed to add the current command line, the oldest history event that has a duplicate to be lost before losing a unique event from the list.
setopt HIST_EXPIRE_DUPS_FIRST
# If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS
# Remove command lines from the history list when the first character on the line is a space, or when one of the expanded aliases contains a leading space
setopt HIST_IGNORE_SPACE
# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS

## Initialisation

## Input/Output

# Don't overwrite existing files with `>`, `>|` must be used to force
unsetopt CLOBBER

# Ignore everything after `#` in a line (unless quoted), but still save to history
# Great for adding tags to commands for fzf history searching
setopt INTERACTIVE_COMMENTS

## Prompting

## Scripts and Functions

## Shell Emulation

# Enable field splitting
# I.E. for loops over a list of stings will consider each element separated by $IFS
# This is done for greater bash compatibility in functions and scripts
# https://zsh.sourceforge.io/FAQ/zshfaq03.html
setopt SH_WORD_SPLIT

## Shell State

## Zle
