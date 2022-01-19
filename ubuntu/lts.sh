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

sudo apt install NGINx

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

if [[ "$1" == "docker" || "$2" == "docker" || "$3" == "docker" ]]; then
    install_docker
elif [[ "$1" == "nginx" || "$2" == "nginx" || "$3" == "nginx" ]]; then
    install_nginx
elif [[ "$1" == "cert" || "$2" == "cert" || "$3" == "cert" ]]; then
    install_certbot_nginx
else
    echo "Tell me what to install docker / nginx / certbot ?"
fi