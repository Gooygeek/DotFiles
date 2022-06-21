if command -v kubectl 2>&1 1>/dev/null; then
    #source <(kubectl completion zsh)

    # Better method
    if [[ ! -f ~/.config/zsh/completions/_kubectl ]]; then
        kubectl completion zsh >| ~/.config/zsh/completions/_kubectl
    fi
fi
