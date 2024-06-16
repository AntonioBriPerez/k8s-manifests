#!/bin/bash
echo "U want to install or uninstall? (i/u)"
read action
if [ $action == "i" ]; then
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
    kubectl apply -f ./config.yaml
elif [ $action == "u" ]; then
    kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
    kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
    kubectl delete -f ./config.yaml
else
  echo "Invalid action"
fi
