

for file in ~/.config/zsh/*.zsh; do
    . $file
done

eval "$(starship init zsh)"
