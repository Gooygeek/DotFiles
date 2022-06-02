

# History Search
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
# Insert last argument of previous command
bindkey '\e.' insert-last-word

# 'Park' the current line
bindkey '^q' push-line
