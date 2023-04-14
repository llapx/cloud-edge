#!/bin/bash

YURTADM_URL=https://github.com/llapx/cloud-edge/releases/download/release-0.0.1/yurtadm
CHECKSUM_URL=https://github.com/llapx/cloud-edge/releases/download/release-0.0.1/yurtadm.sha256sum

if [ ! -f "${BIN_DIR}/yurtadm" ] || [ ! -f "${BIN_DIR}/yurtadm.sha256sum" ]; then
    wget -P ${BIN_DIR} ${YURTADM_URL}
    wget -P ${BIN_DIR} ${CHECKSUM_URL}
fi

(cd ${BIN_DIR} && (echo "$(cat yurtadm.sha256sum)" | sha256sum --check || exit 1))

install -m=755 ${BIN_DIR}/yurtadm /usr/local/bin
