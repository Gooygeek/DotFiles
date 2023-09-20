
QUERY_STRING=$1
pass show $(fd . --base-directory ~/.password-store --exclude ".git*" --exclude ".extensions" --exclude ".gpg-id" --type file | sed 's/.gpg//' | fzf --query "$QUERY_STRING")
