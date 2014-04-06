#!/bin/bash

DOCKER_VERSION=0.9.1

# Install Git
echo "++-- Install Git "
sudo apt-get install -y git

# Install Java 
echo "++-- Install Java Open-JDK-7 "
sudo apt-get -y install openjdk-7-jdk

#Install docker
echo "++-- Install Docker"
sudo apt-get install -y linux-image-extra-`uname -r`

# Add the Docker repository to your apt sources list.
sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

# Update your sources
sudo apt-get update

# Install, you will see another warning that the package cannot be authenticated. Confirm install.
sudo apt-get install -y --force-yes lxc-docker-$DOCKER_VERSION

# Listen on TCP as well as local socket.
cd /etc/init/; sudo rm docker.conf; sudo cp /vagrant/conf/docker.conf .

sudo usermod -aG docker vagrant

echo "++-- Restart Docker"
service docker restart

# Clone docker micropaas images
cd ~
echo "++-- Clone https://github.com/Treeptik/micropaas-image.git"
git clone https://github.com/Treeptik/micropaas-image.git

echo "++-- Build all images ..."
cd micropaas-image
sh buildAll.sh

# Get Jenkins
cd ~
wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war



