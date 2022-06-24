
# Use vi mode
bindkey -v

# History Search with up and down arrows
# [up/down]-line-or-beginning-search combines [up/down]-line-or-search and history-beginning-search-[backward/forward]
# This allows to search from the start to the cursor (not just the first word) AND move through multi-line commands
# It does need to be activated though as these widgets are not enabled by default
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Bind to both keycodes
bindkey "^[OA" up-line-or-beginning-search # Up
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[OB" down-line-or-beginning-search # Down
bindkey "^[[B" down-line-or-beginning-search # Down

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

# Configure Home and End keys ( Fn+<left> and Fn+<right> on Mac )
bindkey "^[OH" vi-beginning-of-line
bindkey "^[[H" vi-beginning-of-line
bindkey "^[OF" vi-end-of-line
bindkey "^[[F" vi-end-of-line

# Entering a ` ` after a `!` or `^` history expansion comand will perform the expansion inline.
# Default, history expansion only occurs when you run the command.
bindkey ' ' magic-space
