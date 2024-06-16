#!/bin/bash
username=$1
echo "Instalando Docker..."
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -u docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $username
newgrp docker
docker run hello-world
cat <<EOF >/home/$username/docker-compose.yml
version: '3.7'
services:
  wireguard:
    image: linuxserver/wireguard
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Madrid
      - SERVERPORT=51820 #optional
      - PEERS=2 #optional
      - PEERDNS=auto #optional
    volumes:
      - /root/wireguard:/config
      - /lib/modules:/lib/modules
      - /usr/src:/usr/src
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    dns:
      - 172.20.0.7
    restart: unless-stopped
EOF
cd /home/$username
docker-compose up -d
docker ps
sudo docker cp wireguard:/config/peer1/peer1.png /home/$username/peer1.png