# zsh autosuggest
# https://github.com/zsh-users/zsh-autosuggestions
. ~/.config/zsh/plugins/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50 # Don't suggest really long strings

# zsh-syntax-highlighting
# Needs to be sourced after everything else. Thus it's been pushed to the essentials file.