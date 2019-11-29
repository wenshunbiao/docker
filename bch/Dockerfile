FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y software-properties-common 
RUN apt-get install -qqy wget
RUN wget https://download.bitcoinabc.org/0.19.1/linux/bitcoin-abc-0.19.1-x86_64-linux-gnu.tar.gz \
    && tar -zvxf  bitcoin-abc-0.19.1-x86_64-linux-gnu.tar.gz \
    && mv bitcoin-abc-0.19.1 bitcoinabc \
    && cp bitcoinabc/bin/* /usr/local/bin 
COPY start.sh /

VOLUME ["/opt/bitcoinabc"]

EXPOSE 8332
EXPOSE 8333
EXPOSE 18332
EXPOSE 18333


CMD ["bitcoind", "--conf=/bch/bitcoind.conf", "--printtoconsole"]
