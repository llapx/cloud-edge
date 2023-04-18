#!/bin/bash

URL_GOOGLE=https://packages.cloud.google.com
APT_GOOGLE=https://apt.kubernetes.io/
URL_ALYYUN=https://mirrors.aliyun.com/kubernetes
APT_ALIYUN=https://mirrors.aliyun.com/kubernetes/apt/

apt-get update
apt-get install -y socat conntrack apt-transport-https ca-certificates curl

mkdir -p /etc/apt/keyings
#curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg ${URL_ALYYUN}/apt/doc/apt-key.gpg
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] ${APT_ALIYUN} kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update

apt-get install -y kubeadm=1.23.17-00 kubectl=1.23.17-00 kubelet=1.23.17-00 kubernetes-cni=1.2.0-00
apt-mark hold kubelet kubeadm kubectl
