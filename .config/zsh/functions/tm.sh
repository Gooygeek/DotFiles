# Plundered from: https://gist.github.com/lucaspar/94b7c0043f2403d8188ed1b84387a50c

# tmux wrapper to re-attach to a tmux session by name
function tm() {
    # if already in a tmux session, do nothing
    if [ -n "$TMUX" ]; then
        echo "Already in tmux session $TMUX"
        return
    fi
    # if no argument is provided, try to re-attach to the last session
    if [ -z "$1" ]; then
        # try to grab the name of the most recently created session
        TMUX_LAST_SESSION=$(tmux ls -F "#{session_created} #{session_name}: #{session_windows} windows (created #{t:session_created}){?session_grouped, (group ,}#{session_group}#{?session_grouped,),}#{?session_attached, (attached),}" 2>/dev/null | sort -Vr | sed 's/\S*\s//' | head -n 1 | awk '{print $1}')
        if [ -n "$TMUX_LAST_SESSION" ] && [[ $TMUX_LAST_SESSION != *"no server"* ]]; then
            echo "Re-attaching to last session: $TMUX_LAST_SESSION"
            tmux attach -t "$TMUX_LAST_SESSION"
            return
        fi
        echo "No tmux sessions found. Use: 'tm <SESSION_NAME>' to create a new one."
        return
    # if there is an argument, try to attach to it or create a session with that name
    else
        echo "Attaching to session $1..."
        tmux attach -t "$1" 2>/dev/null || (echo "Did not find session '$1', creating one..." && tmux new -s "$1")
        return
    fi
}
