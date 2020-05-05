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

# Install full Vim
sudo apt remove --assume-yes vim-tiny
sudo apt install --assume-yes vim


##  DotFiles  ##

# Install dot files (if you have this script it is assumedc that you already have this repo)
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
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install
pip3 install awscli --upgrade --user
mkdir ~/.aws
# cp /mnt/c/Users/kgoldsworthy/.aws/config ~/.aws/config
# cp /mnt/c/Users/kgoldsworthy/.aws/credentials ~/.aws/credentials


##  Other tools  ##

mkdir ~/.local
mkdir ~/.local/bin
cd ~/.local/bin

# terraform
curl -L -O https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
rm terraform_0.12.21_linux_amd64.zip

# Terragrunt
curl -L -O https://github.com/gruntwork-io/terragrunt/releases/download/v0.22.5/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt

#  OPA
curl -L https://openpolicyagent.org/downloads/latest/opa_linux_amd64 -o opa

# Regula
curl -L https://github.com/fugue/regula/archive/v0.2.0.tar.gz -o regula.tar.gz
tar -xzf regula.tar.gz
rm regula.tar.gz

# jq
curl -L -O https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
mv jq-linux64 jq

# Make recently installs tools executable
chmod a+x ~/.local/bin/ -R


##  Additional config  ##

# mkdir ~/bin
# echo "export PATH=\"\$PATH:$HOME/bin:~/.local/bin\"" > ~/.bash.d/dxc-wsl.sh
# echo "alias gotocust='cd /mnt/c/Users/kgoldsworthy/projects/anzaws-client-environments/'" >> ~/.bash.d/dxc-wsl.sh
# echo "alias gotoinfra='cd /mnt/c/Users/kgoldsworthy/projects/infrastructure-modules/'" >> ~/.bash.d/dxc-wsl.sh