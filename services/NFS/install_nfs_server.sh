#!/bin/bash
ip_controlplane=$1
sudo apt-get update
sudo apt-get install nfs-common nfs-kernel-server -y
sudo mkdir -p /data/nfs
sudo chmod 2770 /data/nfs
echo -e "/data/nfs\t$ip_controlplane/24(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports
sudo exportfs -av
sudo systemctl restart nfs-kernel-server
sudo systemctl status nfs-kernel-server
/sbin/showmount -e $ip_controlplane