#!/bin/bash	

cron

rm -rf /root/.local/share/eosio/nodeos/data/state

nodeos --delete-all-blocks  --snapshot $(ls -t /root/.local/share/eosio/nodeos/data/snapshots/*.bin | head -n1) 

