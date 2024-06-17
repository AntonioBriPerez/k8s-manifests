#!/bin/bash
# https://spring.academy/guides/kubernetes-prometheus-grafana
 kubectl create namespace monitoring
 helm install prometheus bitnami/kube-prometheus --namespace monitoring
 helm install grafana bitnami/grafana --values grafana/my_values_grafana.yml --namespace monitoring
 echo "$(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"