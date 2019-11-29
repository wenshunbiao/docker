#!/bin/bash
nginx
#openvpn --config /root/CLIENTNAME.ovpn
#echo "nameserver 8.8.8.8" > /etc/resolv.conf
#sleep 60
geth --ipcdisable --cache=512 --rpc --rpcport 8332 --rpcapi "db,eth,net,web3,personal"


