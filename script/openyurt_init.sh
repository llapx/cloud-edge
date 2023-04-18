#!/bin/bash

CHART_DIR=${OPENYURT_DIR}/charts

kubectl label node ${NODE_NAME} openyurt.io/is-edge-worker=false

iptables -w -P FORWARD ACCEPT

# deploy yurt-app-manager
helm install yurt-app-manager -n kube-system ${CHART_DIR}/yurt-app-manager

for I in `seq 10`
do
    kubectl get pod -n kube-system | grep yurt-app-manager | grep -qw "Running" && break
    sleep 1
done

if [ $I -eq 10 ] ; then
    echo "yurt-app-manager running failed!"
    exit 1
fi

kubectl get svc -n kube-system | grep yurt-app-manager-webhook || exit 1

# add Cloud NodePool
kubectl apply -f ${YAML_DIR}/cloud-nodepool.yaml
kubectl label node ${NODE_NAME} apps.openyurt.io/desired-nodepool=master

# deploy yurt-controller-manager
helm install openyurt -n kube-system  ${CHART_DIR}/openyurt

for I in `seq 10`
do
    kubectl get pod -n kube-system | grep yurt-controller-manager | grep -qw "Running" && break
    sleep 1
done

if [ $I -eq 10 ] ; then
    echo "yurt-controller-manager running failed!"
    exit 1
fi

kubectl apply -f ${YAML_DIR}/raven-controller-manager.yaml
kubectl apply -f ${YAML_DIR}/raven-agent.yaml

sleep 10
