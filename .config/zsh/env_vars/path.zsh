
if [[ -d /opt/homebrew/ ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [[ -d /home/linuxbrew/ ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    # Gcloud cannot be installed via brew, assume it's in .local/bin
    PATH="$HOME/.local/bin/google-cloud-sdk/bin:$PATH"
fi

if [[ -d $HOME/.fzf/ ]]; then
    PATH="$HOME/.fzf/bin:$PATH"
fi

PATH="$HOME/.local/bin:$PATH"
