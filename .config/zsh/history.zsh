# Set file to save history
export HISTFILE=~/.zsh_history
export HISTSIZE=2000 # The maximum number of events stored in the internal history list.
export SAVEHIST=1000 # The maximum number of history events to save in the history file.
# Command patterns to NOT save to the history (only stops it being saved, does not affect interactive history)
export HISTORY_IGNORE="(history|clear|exit|bg|fg|ls|ls *|lls| lls *| *)"
