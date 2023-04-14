#!/bin/bash

export ROOT_DIR=$(realpath $(dirname $(realpath $0))/..)
export SCRIPT_DIR=${ROOT_DIR}/script
export YAML_DIR=${ROOT_DIR}/yaml
export PKG_DIR=${ROOT_DIR}/pkg
export BIN_DIR=${ROOT_DIR}/bin
export K8S_DIR=${ROOT_DIR}/k8s
export OPENYURT_DIR=${ROOT_DIR}/openyurt

export NODE_NAME=$(echo $(hostname) | tr '[:upper:]' '[:lower:]')

fn_help() {
    echo "options:"
    if [ "$1" == "" ] || [ $1 -eq 0 ]; then
        echo "--> $0 help : print this help message."
    else
        echo "    $0 help : print this help message."
    fi

    if [ "$1" == "1" ]; then
        echo "--> $0 init { k8s, yurt }."
    else
        echo "    $0 init { k8s, yurt }."
    fi

    if [ "$1" == "2" ]; then
        echo "--> $0 reset { k8s, yurt }."
    else
        echo "    $0 reset { k8s, yurt }."
    fi

    if [ "$1" == "3" ]; then
        echo "--> $0 install { docker, k8s, yurt, helm }."
    else
        echo "    $0 install { docker, k8s, yurt, helm }."
    fi

    if [ "$1" == "4" ]; then
        echo "--> $0 uninstall { docker, k8s, yurt, helm }."
    else
        echo "    $0 uninstall { docker, k8s, yurt, helm }."
    fi
}

fn_init() {
    if [ "$1" == "k8s" ]; then
        exec ${SCRIPT_DIR}/k8s_init.sh
    elif [ "$1" == "yurt" ]; then
        exec ${SCRIPT_DIR}/openyurt_init.sh
    else
        fn_help 1
    fi
}

fn_reset() {
    if [ "$1" == "k8s" ]; then
        exec ${SCRIPT_DIR}/k8s_reset.sh
    elif [ "$1" == "yurt" ]; then
        exec ${SCRIPT_DIR}/openyurt_reset.sh
    else
        fn_help 2
    fi
}

fn_install() {
    if [ "$1" == "helm" ]; then
        exec ${SCRIPT_DIR}/helm_install.sh
    elif [ "$1" == "k8s" ]; then
        exec ${SCRIPT_DIR}/k8s_install.sh
    elif [ "$1" == "yurt" ]; then
        exec ${SCRIPT_DIR}/openyurt_install.sh
    else
        fn_help 3
    fi
}

fn_uninstall() {
    if [ "$1" == "helm" ]; then
        exec ${SCRIPT_DIR}/helm_uninstall.sh
    elif [ "$1" == "k8s" ]; then
        exec ${SCRIPT_DIR}/k8s_uninstall.sh
    elif [ "$1" == "yurt" ]; then
        exec ${SCRIPT_DIR}/openyurt_uninstall.sh
    else
        fn_help 4
    fi
}

#######################################
## MAIN
#######################################

if [ "$1" == "help" ]; then
    fn_help
elif [ "$1" == "init" ]; then
    fn_init $2
elif [ "$1" == "reset" ]; then
    fn_reset $2
elif [ "$1" == "install" ]; then
    fn_install $2
elif [ "$1" == "uninstall" ]; then
    fn_uninstall $2
else
    fn_help
    exit 1
fi
