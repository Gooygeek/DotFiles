
# Make local bin folder
mkdir ~/.local/bin
cd ~/.local/bin

# Homebrew
# git clone https://github.com/Homebrew/brew homebrew
# eval "$(homebrew/bin/brew shellenv)"
# brew update --force --quiet
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install zsh
brew install make
brew install gnupg
brew install dos2unix
brew install tree
brew install jq
brew install fzf
brew install lazygit
brew install git-delta
brew install ripgrep
brew install fd
brew install tmux
brew install kubenetes-cli
brew install helm
brew install kustomize
brew install k9s
brew install tfenv
brew install starship
brew install go

brew install awscli
brew install --cask google-cloud-sdk

brew tap codefresh-io/cli
brew install codefresh
brew install jsonnet

# Post install config

$(brew --prefix)/opt/fzf/install

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

export gcloud_dir="$(brew --caskroom google-cloud-sdk)/$(brew list --cask --versions google-cloud-sdk | awk '{print $2}')/google-cloud-sdk"

cat >| ~/.bashrc <<EOF
PATH="\$PATH:/usr/local/bin"
PATH="\$PATH:/opt/homebrew/bin"
PATH="\$PATH:\$HOME/Library/Python/3.8/bin"
export {http,https,all}_proxy=http://localhost:3128
export {HTTP,HTTPS,ALL}_PROXY=\$http_proxy
source "$gcloud_dir/completion.bash.inc"
source "$gcloud_dir/path.bash.inc"
if [ -f ~/.bash_custom ]; then
    . ~/.bash_custom
fi
EOF

export fzf_git_dir="$(brew --cellar fzf)/$(brew list --versions fzf | awk '{print $2}')"
echo "[[ \$- == *i* ]] && source \"$fzf_git_dir/shell/completion.bash\" 2> /dev/null" >> $HOME/.fzf.bash
echo "source \"$fzf_git_dir/shell/key-bindings.bash\" 2> /dev/null" >> $HOME/.fzf.bash

rm $HOME/.bash.d/fix_dns.sh

cp ~/.config/lazygit/config.yml ~/Library/Application Support/lazygit/config.yml
