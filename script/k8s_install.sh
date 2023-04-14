#!/bin/bash

apt-get update
apt-get install -y socat conntrack apt-transport-https ca-certificates curl

mkdir -p /etc/apt/keyings
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update

apt-get install -y kubeadm=1.23.17-00 kubectl=1.23.17-00 kubelet=1.23.17-00 kubernetes-cni=1.2.0-00
apt-mark hold kubelet kubeadm kubectl
