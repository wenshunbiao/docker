#!/bin/bash

if [ -d "/home/core/data/openvpn/" ]
then
    echo "already install openvpn"
fi

if [ ! $1 ]
then
    echo "Usage: install 123.123.123.123"
    exit
fi

OVPN_DATA=/home/core/data/openvpn

docker run -v $OVPN_DATA:/etc/openvpn --rm ivories/openvpn ovpn_genconfig -u udp://$1

docker run -v $OVPN_DATA:/etc/openvpn --rm -it ivories/openvpn ovpn_initpki

docker run -v $OVPN_DATA:/etc/openvpn --rm -it ivories/openvpn easyrsa build-client-full CLIENTNAME nopass

docker run -v $OVPN_DATA:/etc/openvpn --rm ivories/openvpn ovpn_getclient CLIENTNAME > /home/core/CLIENTNAME.ovpn

sudo mv /home/core/CLIENTNAME.ovpn $OVPN_DATA/
