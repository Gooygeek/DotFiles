
# Use fzf to search for a previous directory and cd to it.
alias dh="pushd \"\$(dirs -v | cut -d$'\t' -f2 | fzf | sed 's#~#$HOME#')\""
