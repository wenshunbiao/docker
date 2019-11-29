# eos snapshots , peer list , api list

    https://eosnode.tools/snapshots
    https://eosnode.tools/blocks
    https://eosnodes.privex.io/
    https://eospark.com/producers




db eos --build-arg branch=1.7.3
config config.ini and share directory "/root/"
s eos 
d eos 
wget https://github.com/EOS-Mainnet/eos/raw/mainnet-1.0.5/mainnet-genesis.json
nodeos --genesis-json mainnet-genesis.json --delete-all-blocks
rm -rf /root/.local/share/eosio/nodeos/data/stats
wget $(wget --quiet "https://eosnode.tools/api/snapshots?limit=1" -O- | jq -r '.data[0].s3') -O snapshot.tar.gz
tar xvzf snapshot.tar.gz
nodeos --delete-all-blocks  --snapshot $(ls -t /root/.local/share/eosio/nodeos/data/snapshots/*.bin | head -n1) 


