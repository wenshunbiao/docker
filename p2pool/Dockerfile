# Dockerfile for P2Pool-Dash Server
# https://www.dash.org/

FROM alpine
MAINTAINER TheLazieR <thelazier@gmail.com>
LABEL description="Dockerized P2Pool-Dash"

WORKDIR /p2pool
ENV P2POOL_DASH_HOME /p2pool/p2pool-dash
ENV P2POOL_DASH_REPO https://github.com/thelazier/p2pool-dash

RUN apk --no-cache add \
    git \
    perl \
    python \
    python-dev \
    py-twisted \
    gcc \
    g++ \
  && git clone $P2POOL_DASH_REPO $P2POOL_DASH_HOME \
  && cd $P2POOL_DASH_HOME \
  && git submodule init \
  && git submodule update \
  && cd dash_hash && python setup.py install && cd .. \
  && apk -v del \
    git \
    python-dev \
    perl \
    gcc \
    g++

RUN apk --no-cache add bash

EXPOSE 7903 8999 17903 18999

WORKDIR $P2POOL_DASH_HOME
RUN chown -R nobody $P2POOL_DASH_HOME
USER nobody

ENV DASH_RPCUSER dashrpc
ENV DASH_RPCPASSWORD 4C3NET7icz9zNE3CY1X7eSVrtpnSb6KcjEgMJW3armRV
ENV DASH_RPCHOST 192.168.99.1
ENV DASH_RPCPORT 9998
ENV DASH_P2PPORT 9999
ENV DASH_FEE 0
ENV DASH_DONATION 0
ENV DASH_ADDRESS XbDbC3LmKy9VrsFcV9m7BjdsEJtaKPDjTo
ENV DASH_OTHER_PARAM --no-bugreport --disable-advertise

# Default arguments, can be overriden
CMD python run_p2pool.py \
  --give-author $DASH_DONATION \
  -f $DASH_FEE \
  -a $DASH_ADDRESS \
  --dashd-address $DASH_RPCHOST \
  --dashd-rpc-port $DASH_RPCPORT \
  --dashd-p2p-port $DASH_P2PPORT \
  $DASH_OTHER_PARAM \
  $DASH_RPCUSER $DASH_RPCPASSWORD

# End.
