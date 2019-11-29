FROM ubuntu

RUN apt-get update && NPROC=$(nproc) && apt-get install -y qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev libqrencode-dev libboost-all-dev build-essential libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libssl-dev libdb++-dev libssl-dev ufw git 

RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:bitcoin/bitcoin && apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev

RUN git clone https://github.com/ivories/Hshare.git /hshare

RUN cd /hshare/src && make -j$NPROC -f makefile.unix

