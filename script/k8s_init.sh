#!/bin/bash

LOG=/tmp/k8s_init.log

kubeadm init \
 --node-name ${NODE_NAME} \
    --image-repository registry.aliyuncs.com/google_containers | tee -a ${LOG}
# check the result
cat ${LOG} | grep -q "initialized successfully" || (rm -f ${LOG} && exit 1)
rm -f ${LOG}

mkdir -p ${HOME}/.kube
cp -i /etc/kubernetes/admin.conf ${HOME}/.kube/config
chown $(id -u):$(id -g) ${HOME}/.kube/config

sleep 3
kubectl apply -f ${YAML_DIR}/weave-daemonset-k8s.yaml
# waiting for master node startup.
while true
do
    kubectl get nodes ${NODE_NAME} | grep -qw "Ready" && break
    sleep 3
done
