#!/bin/bash
echo "Wanna install or uninstall? (i/u)"
read option
if [ $option == "i" ]; then
    echo "Introduce la IP del controlplane:"
    read controlplane_ip

    echo "Introduce IP del nodo 1:"
    read node1_ip

    echo "Introduce la IP del nodo 2:"
    read node2_ip

    echo "Introduce el nombre de usuario de la maquina"
    read username

    ssh -i ./private_key_m $username@$controlplane_ip 'bash -s' -- $node1_ip < ./install_nfs_server.sh
    ssh -i ./private_key_n1 $username@$node1_ip 'bash -s' -- $node1_ip < ./install_nfs_client.sh
    ssh -i ./private_key_n2 $username@$node2_ip 'bash -s' -- $node1_ip < ./install_nfs_client.sh
    kubectl create namespace nfs
    helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
    helm upgrade --install nfs-subdir-external-provisioner \
    nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=$controlplane_ip \
    --set nfs.path=/data/nfs \
    --set storageClass.onDelete=true \
    --namespace nfs

else
    helm uninstall nfs-subdir-external-provisioner
fi
