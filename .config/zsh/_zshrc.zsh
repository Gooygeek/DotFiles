# Configs are grouped by purpose but alphabetical order might break functionality of certain configs, thus this file is used to define the order that other config files are loaded.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

config_root=~/.config/zsh

# Determine platform
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     export machine=Linux;;
    Darwin*)    export machine=Mac;;
    CYGWIN*)    export machine=Cygwin;;
    MINGW*)     export machine=MinGw;;
    *)          export machine="UNKNOWN:${unameOut}"
esac

# Easy way to reload the zsh Config
alias rezsh='source ~/.zshrc'


## Load Environment Variables
for file in $config_root/env_vars/*.zsh; do
    . $file
done

## Display
. $config_root/display.zsh


## History
. $config_root/history.zsh


## Keybindings
. $config_root/keybindings.zsh


## Options
. $config_root/options.zsh


## Aliases
# Allows Aliases to be expanded when using a bare sudo <command>
alias sudo='sudo '
for file in $config_root/aliases/*.zsh; do
    . $file
done


## Functions (sh and zsh)
for file in $config_root/functions/*; do
    . $file
done


## Autocompletions
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

for file in $config_root/completions/*.zsh; do
    . $file
done
fpath=($config_root/completions $fpath)
compinit


## Tools
for file in $config_root/tools/*; do
    . $file
done


## Plugins
. $config_root/plugins/_load_and_config.zsh


## Other
. $config_root/other.zsh


## Last

eval "$(starship init zsh)"

# Sanity cleanup of PATH, which otherwise can grow duplicate entries (making
# troubleshooting harder than it needs to be)
typeset -U path cdpath fpath manpath

# zsh-syntax-highlighting
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'
