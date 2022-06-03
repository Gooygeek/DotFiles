# zsh autosuggest
# https://github.com/zsh-users/zsh-autosuggestions
. ~/.config/zsh/plugins/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50 # Don't suggest really long strings

# zsh-syntax-highlighting
# Needs to be sourced after everything else. Thus it's been pushed to the root essentials file.

# Load ssh sock if it exists, rather than start a new ssh agent
# See root essentials file for where it's used
source ~/.config/zsh/plugins/ssh-find-agent.sh
