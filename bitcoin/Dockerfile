FROM ubuntu:xenial
MAINTAINER Kyle Manna <kyle@kylemanna.com>

ENV BITCOIN_VER 0.19.1

# define default directory
ENV APP_DIR /app
WORKDIR $APP_DIR

ENV APP_NAME bitcoin

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sSL "https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VER}/bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz" | tar xz
RUN mv bitcoin-${BITCOIN_VER} ${APP_NAME}

EXPOSE 8332 8333 

ENTRYPOINT [""]
CMD ["/app/bitcoin/bin/bitcoind"]
