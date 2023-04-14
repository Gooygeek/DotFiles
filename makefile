#!/bin/bash

pull: # Pull the latest changes
	git config credential.helper cache
	git pull

pull_submod_init: # Pull the latest submodules
	git submodule update --init --recursive

pull_submod: # Pull the latest submodules
	git submodule update --recursive --remote

reset: # Resets the directory to the last commit
	git fetch --all
	git reset --hard origin/master
	git reset --hard HEAD
	git clean -f -d
	git pull

restorebash: # Restores the bash config file
	cp -rf ~/.bashrcOLD ~/.bashrc

spell: # Copies the current working vim spellfile into this repository
	cp -r ~.vim/spell* ~/DotFiles/.vim/spell/

init: # Prep the install
	make pull_submod_init
	make spell

install: # Copy config files
	@echo "Started installation"
	@echo "Copying configs"
	@rsync -r -q .vimrc ~/
	@rsync -r -q .vim ~/
	@rsync -r -q .tmux.conf ~/
	@rsync -r -q .tmux ~/
	@rsync -r -q .gitconfig ~/
	@rsync -r -q .local ~/
	@rsync -r -q .gnupg ~/
	@rsync -r -q .config ~/
	@rsync -r .zshrc ~/
	@echo "Done"
	@tput bel

.PHONY: devcontainer-setup
devcontainer-setup:
	chmod +x ./new\ machine\ setup/devcontainer.sh
	./new\ machine\ setup/devcontainer.sh
