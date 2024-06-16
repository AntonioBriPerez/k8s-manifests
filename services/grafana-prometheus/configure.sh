#!/bin/bash
#SOURCE: https://www.bigbinary.com/blog/prometheus-and-grafana-integration


echo "Wanna install or uninstall? (i/u)"
read action
RELEASE_NAME=grafana-prometheus

if [ $action == "i" ]; then
  echo "Installing Grafana and Prometheus"
  kubectl create namespace monitoring
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
  helm install $RELEASE_NAME prometheus-community/kube-prometheus-stack --namespace monitoring
  kubectl expose service \
    $RELEASE_NAME-kube-pr-prometheus \
    --type=NodePort --target-port=9090 \
    --name=prometheus-node-port-service \
    --namespace=monitoring
  kubectl expose service $RELEASE_NAME \
    --type=LoadBalancer --target-port=3000 \
    --name=grafana-node-port-service \
    --namespace=monitoring
  kubectl get secret --namespace monitoring \
    $RELEASE_NAME \
    -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
elif [ $action == "u" ]; then
  echo "Uninstalling Grafana and Prometheus"
  helm uninstall $RELEASE_NAME --namespace monitoring
  kubectl delete namespace monitoring
else
  echo "Invalid action"
fi
