# Add and commit (should use vim if used with other dotfiles), changes are shown in the buffer but not added, makes for ealiy seesing what was          changed to make better commit messages
gitc() { git add -A && git commit --verbose; }
