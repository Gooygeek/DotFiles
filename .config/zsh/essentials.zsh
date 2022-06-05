# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Easy way to reload the zsh Config
alias rezsh='source ~/.zshrc'

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

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

# Enable field splitting
# I.E. for loops over a list of stings will consider each element separated by $IFS
# This is done for greater bash compatibility in functions and scripts
# https://zsh.sourceforge.io/FAQ/zshfaq03.html
setopt shwordsplit

# Start the agent on login
if [ -z "$SSH_AUTH_SOCK" ] ; then
    ssh_find_agent -a || eval $(ssh-agent) > /dev/null
fi

