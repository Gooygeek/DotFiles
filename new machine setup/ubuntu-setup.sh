##  APT Update/Install  ##

# Update & Upgrade
sudo apt update
sudo apt upgrade

# Install packages known to be in the repos
sudo apt install curl
# sudo apt install git  # Required to get this script
sudo apt install make
sudo apt install unzip
sudo apt install python3
sudo apt install python3-pip
sudo apt install dos2unix

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


##  Nodejs (and NPM)  ##

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs npm


##  AWS CLI  ##
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# pip3 install awscli --upgrade --user
mkdir ~/.aws
# cp /mnt/c/Users/kgoldsworthy/.aws/config ~/.aws/config
# cp /mnt/c/Users/kgoldsworthy/.aws/credentials ~/.aws/credentials


##  Other tools  ##

mkdir -p ~/.local/bin
cd ~/.local/bin

# terraform
curl -L -O https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
rm terraform_0.12.21_linux_amd64.zip

# Terragrunt
curl -L -O https://github.com/gruntwork-io/terragrunt/releases/download/v0.22.5/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt

# jq
curl -L -O https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
mv jq-linux64 jq

# Make recently installs tools executable
chmod a+x ~/.local/bin/ -R


