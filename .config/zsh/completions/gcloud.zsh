if command -v gcloud >/dev/null 2>&1; then
    # `gcloud info` method has fewer dependancies, but is slow
    # source "$(gcloud info --format='value(installation.sdk_root)')/path.zsh.inc"
    # source "$(gcloud info --format='value(installation.sdk_root)')/completion.zsh.inc"

    source "$(dirname $(readlink -f $(which gcloud)))/../completion.zsh.inc"
    source "$(dirname $(readlink -f $(which gcloud)))/../path.zsh.inc"
fi
