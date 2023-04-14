#!/bin/bash

sudo kubeadm reset -f
sudo rm -rf /etc/cni/net.d

rm -rf $HOME/.kube

