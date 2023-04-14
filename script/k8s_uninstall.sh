#!/bin/bash

apt-mark unhold kubelet kubeadm kubectl
apt-get purge -y kubeadm=1.23.17-00 kubectl=1.23.17-00 kubelet=1.23.17-00 kubernetes-cni=1.2.0-00
rm -rf /opt/cni