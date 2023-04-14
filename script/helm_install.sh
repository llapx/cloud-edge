#!/bin/bash

HELM_PKG=helm-v3.11.2-linux-amd64.tar.gz
CHECKSUM=${HELM_PKG}.sha256sum
HELM_URL=https://get.helm.sh/${HELM_PKG}
CHECKSUM_URL=https://get.helm.sh/${CHECKSUM}

if [ ! -f "${PKG_DIR}/${HELM_PKG}" ] || [ ! -f "${PKG_DIR}/${CHECKSUM}" ]; then
    wget -P ${PKG_DIR} ${HELM_URL}
    wget -P ${PKG_DIR} ${CHECKSUM_URL}
fi

(cd ${PKG_DIR} && (echo "$(cat ${CHECKSUM})" | sha256sum --check || exit 1))

tar -xf ${PKG_DIR}/${HELM_PKG} -C /tmp/
install -m=755 /tmp/linux-amd64/helm /usr/local/bin
rm -rf /tmp/linux-amd64
