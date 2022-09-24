
# %sudo   ALL=(ALL:ALL) NOPASSWD:ALL

##  APT Update/Install  ##

# Update & Upgrade
sudo apt update
sudo apt upgrade

# Prerequisites
# sudo apt install git  # Required to get this script
sudo apt install curl
sudo apt install make
sudo apt install unzip

# Install full Vim
sudo apt remove --assume-yes vim-tiny
sudo apt install --assume-yes vim

##  Misc tools  ##

## Initialize bin folder
mkdir -p ~/.local/bin
cd ~/.local/bin

##  Nodejs (and NPM)
# curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# sudo apt-get install -y nodejs npm
# sudo apt install -y npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

## gcloud CLI
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-379.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-sdk-379.0.0-linux-x86.tar.gz
./google-cloud-sdk/install.sh
ln -s ~/.local/bin/google-cloud-sdk/bin/gcloud ~/.local/bin/gcloud

# Make recently installs tools executable
chmod a+x ~/.local/bin/ -R
