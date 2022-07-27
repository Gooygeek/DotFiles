
PATH="$PATH:$HOME/.local/bin"

if [[ -d /opt/homebrew/ ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [[ -d /home/linuxbrew/ ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

PATH="$PATH:$HOME/.fzf/bin"

PATH="$PATH:/usr/local/go/bin"

PATH="$PATH:$HOME/.tfenv/bin"
