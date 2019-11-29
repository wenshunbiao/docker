FROM debian:jessie

RUN apt-get update && apt-get install -y apt-transport-https wget&& wget -qO - https://apt.z.cash/zcash.asc | apt-key add - && echo "deb [arch=amd64] https://apt.z.cash/ jessie main" |  tee /etc/apt/sources.list.d/zcash.list && apt-get update && apt-get install -y zcash && zcash-fetch-params

RUN mkdir -p ~/.zcash && \
echo "addnode=mainnet.z.cash" >~/.zcash/zcash.conf && \
echo "rpcuser=username" >>~/.zcash/zcash.conf && \
echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >>~/.zcash/zcash.conf && \
echo 'gen=1' >> ~/.zcash/zcash.conf && \
echo "genproclimit=-1" >> ~/.zcash/zcash.conf

CMD zcashd
