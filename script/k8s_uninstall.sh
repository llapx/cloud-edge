#!/bin/bash

INSTALL_DIR=/usr/local/bin
CNI_DIR=/opt/cni/bin

systemctl stop kubelet
sleep 3
systemctl disable kubelet
sleep 1

rm -rf ${CNI_DIR}
rm -rf ${INSTALL_DIR}/{kubectl,kubeadm,kubelet}
rm -rf /etc/systemd/system/kubelet.service.d
rm -rf /etc/systemd/system/kubelet.service

