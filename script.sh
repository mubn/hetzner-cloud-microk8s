#!/bin/sh

# This script installs microk8s

# Install microk8s when not a custom image with
# microk8s preinstalled is used
if [ "$1" = false ]; then
  apt install -y python3
  cp /usr/bin/python3 /usr/bin/python
  apt install -y snapd
  snap install microk8s --classic
  snap alias microk8s.kubectl kubectl
fi
