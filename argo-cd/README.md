# Instalación ARGO-CD

Para configurar los deployments y servicios:
```
kubectl -f apply install.yml
```


Para convertir el servidor en tipo LoadBalancer y que sea accesible desde fuera
```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```
