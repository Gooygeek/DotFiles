
# Use fzf to search for a previous directory and cd to it.
alias dh="pushd \$(dirs -v | awk '{print \$2}' | fzf | sed \"s#~#$HOME#\")"
