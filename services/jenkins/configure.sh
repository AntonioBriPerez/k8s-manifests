#!/bin/bash
echo "U want to install or uninstall Jenkins? (i/u)"
read choice
if [ $choice == "i" ]
then
  kubectl create namespace jenkins
  kubectl apply -f ./manifests/ -n jenkins
  sleep 30
  echo "Jenkins password: $(kubectl get secret jenkins -n jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)"
elif [ $choice == "u" ]
then
    kubectl delete -f ./manifests/ -n jenkins
    kubectl delete namespace jenkins
else
    echo "Invalid choice"
fi