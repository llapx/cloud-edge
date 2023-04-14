#!/bin/bash

REL=v1.23.17
ARCH=amd64

download_and_checksum() {
    NAME=$1
    echo "Downloading ${NAME}..."
    curl -LO https://dl.k8s.io/release/${REL}/bin/linux/${ARCH}/${NAME}
    echo "Done!"

    echo "Downloading ${NAME}.sha256..."
    curl -LO https://dl.k8s.io/${REL}/bin/linux/${ARCH}/${NAME}.sha256
    echo "Done!"

    echo "Checksum..."
    echo "$(cat ${NAME}.sha256)  ${NAME}" | sha256sum --check
}

download_systemd_file() {
    RELEASE_VERSION="v0.4.0"
    curl -LO "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service"
    curl -LO "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf"
}

download_and_checksum kubectl
sleep 1
download_and_checksum kubeadm
sleep 1
download_and_checksum kubelet
#sleep 1
#download_systemd_file
