#!/usr/bin/env bash

function install_docker(){

# Let's start with installing Docker
echo "Installing Docker Engine..."

# Uninstall any older versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# Let's setup the apt repo over HTTPS
sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Adds official Docker GPG keys

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Sets stable repo

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Fetch latest apt updates

sudo apt-get update

# Let's finally insall docker engine

sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "Docker Engine Installation Successful"
}

function install_nginx(){
# Let's install NGINX

echo "Installing NGINX"

# Update the apt packages repo

sudo apt update

# Install NGINx

sudo apt install nginx

echo "NGINX Installation success"

}

function install_certbot_nginx(){
# Let's install certbot for NGINX

echo "Installing Certbot for NGINX"

# Update the apt-get packages repo

sudo apt-get update

# Install certbot

sudo apt-get install certbot

sudo apt-get install python3-certbot-nginx

echo "NGINX Certbot Installation success"

# Further Instructions
echo "change your server name to your domain name:" 
echo "server_name example.com www.example.com;"
echo "to verify use: sudo nginx -t && sudo nginx -s reload"
echo "to obtain certificate use:"
echo "sudo certbot --nginx -d example.com -d www.example.com"

}

function nvm_node(){
echo "Installing nvm and node lts"
# Get nvm 0.39.1    
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# Install lts node
nvm install --lts
echo "Node installed successfully"
node -v
}

if [[ "$1" == "docker" || "$2" == "docker" || "$3" == "docker" || "$4" == "docker" ]]; then
    install_docker
fi

if [[ "$1" == "nginx" || "$2" == "nginx" || "$3" == "nginx" || "$4" == "nginx" ]]; then
    install_nginx
fi

if [[ "$1" == "cert" || "$2" == "cert" || "$3" == "cert" || "$4" == "cert" ]]; then
    install_certbot_nginx
fi

if [[ "$1" == "node" || "$2" == "node" || "$3" == "node" || "$4" == "node" ]]; then
    nvm_node
fi

if [ $# -eq 0 ]; then
    echo "Tell me what to install docker / nginx / certbot / node ?"
fi