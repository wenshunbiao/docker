#install

./install.sh yourip
edit openvpn.conf
change udp to tcp4
edit CLIENTNAME.ovpn 
change ip to 127.0.0.1 51199 tcp4

# !!!important!!!
obfsproxy must use ipv4,so openvpn.service must set the ip address like 127.0.0.1,don't use 0.0.0.0
