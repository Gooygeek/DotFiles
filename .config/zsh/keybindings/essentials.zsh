
# Use vi mode
bindkey -v

# History Search with up and down arrows
bindkey '\eOA' history-search-backward
bindkey '\eOB' history-search-forward
# `ESC, .` = Insert last argument of previous command
bindkey '\e.' insert-last-word

# `ESC + q` = 'Park' the current line
# push-line is for simgle line, push-input works for multi-line
bindkey '^q' push-input

# `ESC` to toggle vi command / insert mode
bindkey '^[' vi-cmd-mode
bindkey -M vicmd "^[" vi-insert

# Using 'backward-delete-char' instead of 'vi-backward-delete-char' to properly delete past where vi-insert dropped the cursor to
# The Backspace key can be mapped to either key combination depending on the system. Includoing both for compatiblity
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# Entering a ` ` after a `!` or `^` history expansion comand will perform the expansion inline.
# Default, history expansion only occurs when you run the command.
bindkey ' ' magic-space
