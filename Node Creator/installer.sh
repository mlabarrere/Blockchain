#!/bin/bash

# Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them:
apt-get remove -y docker docker-engine

apt-get -y update

# FAIRE LE TEST DE TYPE DE DISTRIBUTION ##########################################LHFMQLSDHG§LFDSQHG§LQDGFMQSDJFMHJD%
#CODENAME=
#apt-get install \
#    linux-image-extra-$(uname -r) \
#    linux-image-extra-virtual

# Install using the repository

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# FAIRE LE TEST DE TYPE DE CPU ##########################################LHFMQLSDHG§LFDSQHG§LQDGFMQSDJFMHJD%

# AMD64
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#ARMHF
#add-apt-repository \
#   "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) \
#   stable"

apt-get update

apt-get install -y docker-ce jq

docker build -t ey/quorum .