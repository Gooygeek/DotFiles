# Coloursheme Option 1

# set pane colors - hilight the active pane
set-option -g pane-border-style fg=colour235 #base02
set-option -g pane-active-border-style fg=colour240 #base01

# colorize messages in the command line
set-option -g message-style bg=black #base02
set-option -g message-style fg=brightred #orange

# ----------------------
# Status Bar
#-----------------------
set-option -g status on                # turn the status bar on
set -g status-interval 5               # set update frequencey (default 15 seconds)
set -g status-justify centre           # center window list for clarity
#set-option -g status-position top    # position the status bar at top of screen

# visual notification of activity in other windows
setw -g monitor-activity on
set -g visual-activity on

# set color for status bar
set-option -g status-bg colour234 #base02
set-option -g status-fg yellow #yellow
# set-option -g status-style dim

# set window list colors - red for active and cyan for inactive
set-window-option -g window-status-style fg=white
set-window-option -g window-status-style bg=colour234
set-window-option -g window-status-style dim

set-window-option -g window-status-current-style fg=white
set-window-option -g window-status-current-style bg=blue
set-window-option -g window-status-current-style bright

# show host name and IP address on left side of status bar
set -g status-left-length 35
set -g status-left "#[fg=green] #h : #[fg=brightblue]#(curl icanhazip.com) "

# show session name, window & pane number on right side of the status bar
set -g status-right-length 35
set -g status-right "#[fg=green]#S #I:#P"
