##  APT Update/Install  ##

# Update & Upgrade
sudo apt update
sudo apt upgrade

# Prerequisites
sudo apt install curl
# sudo apt install git  # Required to get this script
sudo apt install make
sudo apt install unzip

# Install full Vim
sudo apt remove --assume-yes vim-tiny
sudo apt install --assume-yes vim


##  DotFiles  ##

# Install dot files (if you have this script it is assumed that you already have this repo)
# mkdir ~/projects
# cd ~/projects
# git clone https://github.com/gooygeek/Dotfiles.git
cd ~/projects/Dotfiles
make init
make install

## Via package manager ##

sudo apt install -y python3
sudo apt install -y python3-pip

sudo apt install -y dos2unix

sudo apt install -y tmux

sudo apt install -y ripgrep

sudo apt install -y fd-find
ln -s $(which fdfind) ~/.local/bin/fd

##  Misc tools  ##

## Initialize bin folder
mkdir -p ~/.local/bin
cd ~/.local/bin

##  Nodejs (and NPM)
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs npm

##  AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# pip3 install awscli --upgrade --user
# ln -s /mnt/c/Users/kieran/.aws .aws

## terraform
#curl -L -O https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
#unzip terraform_0.12.21_linux_amd64.zip
#rm terraform_0.12.21_linux_amd64.zip
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* /usr/local/bin

## Terragrunt
curl -L -O https://github.com/gruntwork-io/terragrunt/releases/download/v0.22.5/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt

# jq
curl -L -O https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
mv jq-linux64 jq

# Gitui
curl -L -O https://github.com/extrawurst/gitui/releases/download/v0.18.0/gitui-linux-musl.tar.gz
tar -xvf gitui-linux-musl.tar.gz
rm gitui-linux-musl.tar.gz

# Make recently installs tools executable
chmod a+x ~/.local/bin/ -R

# Starship prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
eval "$(starship init bash)" >> ~/.bash_profile

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

## WSL Symlinks ##

# ln -s XXXX ~/projects
# ln -s XXXX ~/Downloads
# ln -s XXXX ~/Documents
