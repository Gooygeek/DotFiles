if command -v helm 2>&1 1>/dev/null; then
    #source <(helm completion zsh)

    # Better method
    if [[ ! -f ~/.config/zsh/completions/_helm ]]; then
        helm completion zsh >| ~/.config/zsh/completions/_helm
    fi
fi
