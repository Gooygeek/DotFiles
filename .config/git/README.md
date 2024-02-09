# Git Config

This file documents interesting and important git config details.

## Config

### Swappable User Section

The user section of the global git config is swappable, this uses gitconfig's 'import' feature (read at runtime).
By modifying the file being imported, this allows for the config to be swapped out on the fly.
Of particular note is the 'user' section, meaning that you can swap between different users (name, email, gpg key, etc.).

To make the swapping easy, the 'gite' cli tool was developed.

It works by reading different configs in the 'users' directory and presents them as options.
It then copies the selected config to the file called 'ACTIVE' which gitconfig will import.

## Aliases

As there are a lot of aliases, to prevent bloating the main gitconfig file, these aliases are saved in the file 'alias.gitconfig' and are imported by the main gitconfig file.

This will not be a complete enumeration of all aliases, but will cover some of the more important and useful ones.

- `alias`: Print all aliases

- `aa`: Add All
- `co`: Checkout
- `ss`: Short status
- `lg`: Nice log
- `unstage`: Remove all files from the stage
- `publish`: Push, but also set upstream (useful when pushing a branch for the first time)
- `untrack`: Remove upstream branch information (useful when renaming a branch)
- `prune-tags`: Remove all tags that exist locally but not on the remote (important, as a push would recreate those tags on the remote)

### Global ignore file

The file 'global_ignore' is referened in the gitconfig.
It provides a .gitignore file that is the default for the whole system, all .gitignore files in repos are merely overlayed on top.

Thus this file should contain only patterns that I definitely never ever want in any repo.

### Commit message

Saved in the file 'gitmessage' which is referened in the gitconfig, this file provides a bit of text that will appear whenever using an editor to write a commit message.

It contains details about hw to write a good commit message.

## Tools

### Precommit

### Lazy Git

Aliased to `lg`

### git-vee??
