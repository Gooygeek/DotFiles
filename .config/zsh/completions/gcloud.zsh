if command -v gcloud >/dev/null 2>&1; then
    if [ "$machine" = "Mac" ]; then
        source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
        source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    elif [ "$machine" = "Linux" ]; then
        source "$(which gcloud | sed 's/\/gcloud$//' )/../completion.zsh.inc"
        source "$(which gcloud | sed 's/\/gcloud$//' )/../path.zsh.inc"
    fi
fi
