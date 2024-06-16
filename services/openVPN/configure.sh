#!/bin/bash
kubectl create namespace openvpn
helm repo add devtron http://helm.devtron.ai/
helm install my-openvpn devtron/openvpn --namespace openvpn --version 4.2.5
chmod +x ./create-key.sh
./create-key.sh