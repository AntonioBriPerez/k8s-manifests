#!/bin/bash
echo "Introduce la IP del controlplane:"
read controlplane_ip
echo "Introduce el nombre de usuario de la maquina"
read username
ssh -i ./privatekey $username@$controlplane_ip 'bash -s' -- "$username" <<'EOF'
$(<./configure_wireguard.sh)
EOF
scp -i ./private_key $username@controlplane_ip:/home/vagrant/peer2.png ./peer2.png