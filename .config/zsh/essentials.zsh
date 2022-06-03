# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Easy way to reload the zsh Config
alias rezsh='source ~/.zshrc'

## Load Environment Variables
for file in ~/.config/zsh/env_vars/*.zsh; do
    . $file
done

## Load aliases
# Allows Aliases to be expanded when using a bare sudo <command>
alias sudo='sudo '
for file in ~/.config/zsh/aliases/*.zsh; do
    . $file
done
# Allow completions to work for aliases
unsetopt completealiases

## Load functions (sh and zsh)
# for file in ~/.config/zsh/functions/*; do
#     . $file
# done

## Load autocompletions
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

for file in ~/.config/zsh/completions/*.zsh; do
    . $file
done
fpath=(~/.config/zsh/completions $fpath)
compinit

## Load keybindings
for file in ~/.config/zsh/keybindings/*.zsh; do
    . $file
done

## Load plugins
. ~/.config/zsh/plugins/_load_and_config.zsh

# Start the agent on login
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
fi

# fzf keybindings and auto-completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'