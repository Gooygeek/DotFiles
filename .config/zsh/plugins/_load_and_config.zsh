# fzf-tab
#https://github.com/Aloxaf/fzf-tab
. ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# zsh autosuggest
# https://github.com/zsh-users/zsh-autosuggestions
. ~/.config/zsh/plugins/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50 # Don't suggest really long strings

# zsh-autopair
# https://github.com/hlissner/zsh-autopair
. ~/.config/zsh/plugins/zsh-autopair/autopair.zsh
autopair-init

# fast syntax highlighting
# https://github.com/zdharma-continuum/fast-syntax-highlighting
# *Might* be a bit better than the other highlighting plugin, but it's too hard to choose between them, I'll stick with the current for now
# . ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Load ssh sock if it exists, rather than start a new ssh agent
# See ssh.zsh file for where it's used
# source ~/.config/zsh/plugins/ssh-find-agent.sh
