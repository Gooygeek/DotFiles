if command -v kubectl 2>&1 1>/dev/null; then
    source <(kubectl completion zsh)
fi
