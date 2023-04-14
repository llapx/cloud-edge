#!/bin/bash

INSTALL_DIR=/usr/local/bin
CNI_DIR=/opt/cni/bin
CNI_PKG=${PKG_DIR}/cni-plugins-linux-amd64-v1.2.0.tgz

mkdir -p ${INSTALL_DIR}
mkdir -p ${CNI_DIR}
mkdir -p /etc/systemd/system/kubelet.service.d

install -m=755 ${K8S_DIR}/bin/{kubectl,kubeadm,kubelet} ${INSTALL_DIR}
tar -xvf ${CNI_PKG} -C ${CNI_DIR}

cat ${K8S_DIR}/systemd/kubelet.service | sed "s:/usr/bin:${INSTALL_DIR}:g" | tee /etc/systemd/system/kubelet.service
cat ${K8S_DIR}/conf/10-kubeadm.conf | sed "s:/usr/bin:${INSTALL_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sleep 3

systemctl enable --now kubelet
