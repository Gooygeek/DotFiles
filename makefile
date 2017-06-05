#!/bin/bash

pull:
	git config credential.helper cache
	git pull

reset:#resets the directory to the last commit
	git fetch --all
	git reset --hard origin/master
	git reset --hard HEAD
	git clean -f -d
	git pull

restorebash: #restores the bash config file
	cp -rf ~/.bashrcOLD ~/.bashrc
	
