#!/bin/bash
ZCASH_CONF="/root/.zcash/zcash.conf"

if ! [ -f "/root/.zcash/zcash.conf" ]; then
    echo "rpcuser=zcash" > /root/.zcash/zcash.conf
    echo "rpcpassword=`pwgen 20 1`" >> /root/.zcash/zcash.conf
    echo "addnode=mainnet.z.cash" >> /root/.zcash/zcash.conf
fi

zcash-fetch-params
zcashd $*
