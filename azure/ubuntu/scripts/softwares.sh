#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install curl wget tree net-tools git unzip -y

# kubectl
curl -sLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -rf kubectl
kubectl version --client

# Kustomize
curl -sL "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | sudo bash
sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize
rm -rf kustomize
kustomize version

# helm 
curl -sL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# argocd cli
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm -rf argocd-linux-amd64
argocd version --client

# Docker 
curl -fsSL https://get.docker.com -o install-docker.sh
bash install-docker.sh

# Kubectx & Kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# Kubernetes Krew Plugins
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz"
tar zxvf krew-linux_amd64.tar.gz
./krew-linux_amd64 install krew
rm -rf LICENSE krew*