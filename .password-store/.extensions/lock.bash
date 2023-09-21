# In combination with unlock.bash, based on pass-coffin

# list of variables and functions from password-store.sh used in this extension
# PREFIX - the location of the directory where pass data is kept

vault_dir=.vault
ext_dir=.extensions

pushd $PREFIX 2>&1 > /dev/null

if [[ -e ".lock" ]]; then
    echo "Vault is already locked"
    exit 1
fi

if [[ ! -d $vault_dir ]]; then
    mkdir $vault_dir
    pushd $vault_dir 2>&1 > /dev/null
    git init -b main
    mv .git dot.git
    popd 2>&1 > /dev/null
fi

set_gpg_recipients "$vault_dir"

tar c \
    --exclude ".gpg-id" \
    --exclude ".gpg-id.sig" \
    --exclude "$vault_dir" \
    --exclude "$ext_dir" \
    . \
    | gpg -e "${GPG_RECIPIENT_ARGS[@]}" -o "$vault_dir/vault-$(date).tar.gpg"

find . -maxdepth 1 ! -name "." ! -name ".gpg-id" ! -name ".gpg-id.sig" ! -name ".gitignore" ! -name "$vault_dir" ! -name "$ext_dir" -exec rm -rf {} \;
mv $vault_dir/dot.git ./.git

touch .lock
