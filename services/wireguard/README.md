# Importante
El servidor VPN lo ejecutamos como contenedor de Docker en el controlplane ya que para configurarlo en K8s da bastantes problemas. 

Una vez se haya levantado el contenedor, el fichero de configuración del cliente VPN tendremos que añadirle lo siguiente:
```
[Interface]
PrivateKey = xxx
ListenPort = 51820
Address = 10.13.13.2/32
DNS = 8.8.8.8, 8.8.4.4 #importante!!

[Peer]
PublicKey = xxx
PresharedKey = xxx
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = <ip publica router>:51820 #importante!!
```
