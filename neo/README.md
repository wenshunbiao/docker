# neo-python
Docker image for neo-python that supports neo-python command line arguments and adds --bootstrap option, to bootstrap the test- or main NEO chain prior to running prompt.py. Bootstrapping persistent requires a mounted volume.

Docker image at: https://hub.docker.com/r/jorritvandenberg/neo-python-docker/

To run the container on the testchain with a mounted volume:
docker run -it -v /host/path/to/where/you/want/to/store/the/chain:/neo-python/Chains jorritvandenberg/neo-python-docker

To bootstrap the main chain
docker run -it -v /host/path/to/where/you/want/to/store/the/chain:/neo-python/Chains jorritvandenberg/neo-python-docker -m --bootstrap

Supported options:
-m / --mainnet
(use NEO main net)  
-p / --privnet
(use private net)  
--coznet
(use City of Zion net)  
-c=/path/to/config/file / --config=/path/to/config/file
(Config file should be mounted in the Docker container on this path)  
-t=<theme> / --set-default-theme=<theme>
(neo-python prompt theme, can be dark or light)  
--version=neo-python-version
(set the neo-python version to be used)  
--bootstrap
(bootstrap the blockchain, can be used with main or testnet)  
-n / --notifications
(bootstrap notifcation database, only to be used in combination with --bootstrap)  

Note that bootstrapping does not work with --privnet or --coznet and -c doesn't work with --mainnet.  

To add an existing wallet from your host to the container:
docker run -it -v /host/path/to/where/you/want/to/store/the/chain:/neo-python/Chains -v /host/path/to/wallet:/neo-python/wallet jorritvandenberg/neo-python-docker

After closing the containers, the chain will be available in on the path that you defined.

Important:
- Make sure that you close your wallet in neo-python ("wallet close") before shutting down the container. Otherwise the wallet can get's stuck in a vulnerable state.
- The volume persists the blockchain. If you want to start with a clean slate, remove the files in the host path you defined.
