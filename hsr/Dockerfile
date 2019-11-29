FROM ubuntu

RUN apt update && apt install -y wget
RUN wget https://github.com/ivories/coin/raw/master/hsr/hshared && mv hshared /usr/bin
RUN chmod -R 777 /usr/bin/hshared

RUN apt-get update && apt-get install -y libminiupnpc-dev libboost-all-dev
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:bitcoin/bitcoin && apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev
RUN apt-get install -y nginx
