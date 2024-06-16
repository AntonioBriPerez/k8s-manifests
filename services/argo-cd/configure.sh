#/bin/bash
echo "U want to install or uninstall ArgoCD? (i/u)"
read  action
if [ "$action" == "i" ]; then
    echo "Installing ArgoCD"
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    kubectl get svc -n argocd
    echo "La master password es: "
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    echo "ArgoCD installed"
elif [ "$action" == "u" ]; then
    echo "Uninstalling ArgoCD"
    kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl delete namespace argocd
    echo "ArgoCD uninstalled"
else
    echo "Invalid option"
fi