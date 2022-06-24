
PATH="$PATH:$HOME/.local/bin"

if [[ -d /opt/homebrew/ ]]; then
    PATH="$PATH:/opt/homebrew/bin/"
fi

PATH="$PATH:$HOME/.fzf/bin"

PATH="$PATH:/usr/local/go/bin"

PATH="$PATH:$HOME/.tfenv/bin"
