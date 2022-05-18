
# Make local bin folder
mkdir ~/.local/bin
cd ~/.local/bin

# Homebrew
# git clone https://github.com/Homebrew/brew homebrew
# eval "$(homebrew/bin/brew shellenv)"
# brew update --force --quiet
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install make
brew install gnupg
brew install dos2unix
brew install tree
brew install jq
brew install jsonnet
brew install fzf
brew install lazygit
brew install git-delta
brew install ripgrep
brew install ripgrep-all
brew install fd
brew install tmux
brew install kubenetes-cli
brew install helm
brew install kustomize
brew install t
brew install k9s
brew install tfenv
brew install starship
brew install go

brew install awscli
brew install --cask google-cloud-sdk

brew install codefresh

# Post install config

ln -s $(which fdfind) ~/.local/bin/fd

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Dotfiles

# ../installDotFiles.sh

# Make a bunch of fixes to account for MACOS being weird

sed 's/PATH="$PATH:\/usr\/local\/go\/bin"/PATH="$PATH:$HOME\/.local\/bin\/go\/bin"/g' $HOME/.bash_custom >| temp
mv temp $HOME/.bash_custom
sed "s/alias ls='ls -AF --format=horizontal --color=auto'/alias ls='ls -AF --color=auto'/g" $HOME/.bash_custom >| temp
mv temp $HOME/.bash_custom
sed "s/alias lls='ls -AFltrh --time-style long-iso --color=auto'/alias lls='ls -AFltrh --color=auto'/g" $HOME/.bash_custom >| temp
mv temp $HOME/.bash_custom

echo "PATH=\"\$PATH:/usr/local/bin\"" >> $HOME/.bashrc
echo "PATH=\"\$PATH:/opt/homebrew/bin\"" >> $HOME/.bashrc

echo "source \"/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc\"" >> $HOME/.bashrc

export fzf_git_dir="$(brew --cellar fzf)/$(brew list --versions fzf | awk '{print $2}')"
echo "[[ \$- == *i* ]] && source \"$fzf_git_dir/shell/completion.bash\" 2> /dev/null" >> $HOME/.fzf.bash
echo "source \"$fzf_git_dir/shell/key-bindings.bash\" 2> /dev/null" >> $HOME/.fzf.bash

echo "eval \"\$(starship init bash)\"" >> $HOME/.bashrc
echo "export {http,https,all}_proxy=http://localhost:3128" >> $HOME/.bashrc
echo "export {HTTP,HTTPS,ALL}_PROXY=\$http_proxy" >> $HOME/.bashrc
rm $HOME/.bash.d/fix_dns.sh
