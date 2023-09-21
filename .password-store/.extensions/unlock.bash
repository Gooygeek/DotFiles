# In combination with lock.bash, based on pass-coffin

# list of variables and functions from password-store.sh used in this extension
# PREFIX - the location of the directory where pass data is kept

vault_dir=.vault
ext_dir=.extensions

pushd $PREFIX 2>&1 > /dev/null

if [[ ! -e ".lock" ]]; then
    echo "Vault is already unlocked"
    exit 1
fi

if [[ ! -d $vault_dir ]]; then
    mkdir $vault_dir
    pushd $vault_dir 2>&1 > /dev/null
    git init -b main
    popd 2>&1 > /dev/null
fi

rm -rf $vault_dir/dot.git
mv .git $vault_dir/dot.git

$GPG -d "${GPG_OPTS[@]}" "$(find $vault_dir -name "vault*" | fzf)" | tar x

rm .lock
