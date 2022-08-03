if command -v gcloud >/dev/null 2>&1; then
    # `gcloud info` method has fewer dependancies, but is slow
    # source "$(gcloud info --format='value(installation.sdk_root)')/path.zsh.inc"
    # source "$(gcloud info --format='value(installation.sdk_root)')/completion.zsh.inc"

    source "$(\fd -L "completion.zsh.inc" $(readlink -f $(which gcloud) | sed 's/\/gcloud$//' )/..)"
    source "$(\fd -L "path.zsh.inc" $(readlink -f $(which gcloud) | sed 's/\/gcloud$//' )/..)"
fi
