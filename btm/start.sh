#!/bin/bash /bin/sh 
nginx
#/go/src/github.com/bytom/cmd/bytomd/bytomd init --chain_id testnet
##mainnet
#/go/src/github.com/bytom/cmd/bytomd/bytomd node 


bytomd init --chain_id $1
bytomd node




