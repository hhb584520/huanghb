#!/usr/bin/env bash

set -ex

prepare(){
#update
sudo apt-get update

#install java jdk
sudo apt install -y openjdk-8-jdk curl git
sudo apt-get install -y unzip maven docker.io
}


repo_install(){
#environment setup
echo "Installing openssh-server, git, npm, maven and docker"
sudo apt-get install -y openssh-server
sudo apt-get install -y git docker

#repo install

# Add settings.xml into maven
#wget -O settings.xml https://jira.onap.org/secure/attachment/10829/settings.xml
#sudo cp settings.xml ./m2/settings.xml
#sudo cp settings.xml /etc/maven/settings.xml

}


#invoke functions
#prepare
#repo_install
#titan_setup
#resource
#traversal

echo "done"
