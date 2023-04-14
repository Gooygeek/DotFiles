
# Unlock the gpg key used by the current git config to add it to the gpg-agent password cache
gpg-unlock-current-git-key() {
    KeyId=$(git config --get user.signingKey)
    KeyGrip=$(gpg --with-keygrip --list-secret-keys ${KeyId} | head -3 | tail -1 | awk '{print $3}')
    KeyEmail=$(gpg --with-keygrip --list-secret-keys ${KeyId} | grep -o "<.*@.*>")
    # KeyCacheStatus=$(gpg-connect-agent "keyinfo ${KeyGrip}" /bye | awk '{print $7}') # "-" = not cached, "1" = cached
    # echo "Email: $KeyEmail\\nKey ID: $KeyId\\nKey Grip: $KeyGrip\\nCache Status: $KeyCacheStatus"
    echo "GET_PASSPHRASE ${KeyGrip} ${KeyEmail} > Please+unlock+key:" | gpg-connect-agent > /dev/null
}

# Reload config and clear password cache
gpg-reload-agent() {
    echo "RELOADAGENT" | gpg-connect-agent > /dev/null
}

gpg-kill-agent() {
    pkill -9 gpg-agent ; gpg-agent --daemon >/dev/null
}
