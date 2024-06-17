#!/bin/bash
echo "Introduce la IP del controlplane:"
read controlplane_ip
echo "Introduce el nombre de usuario de la maquina"
read username
ssh -i ../../ssh_keys/private_key_cp $username@$controlplane_ip 'bash -s' -- $username < ./configure_wireguard.sh
scp -i ../../ssh_keys/private_key_cp $username@$controlplane_ip:/home/vagrant/peer1.png ~/peer1.png