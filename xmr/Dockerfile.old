FROM ubuntu:18.04 AS build

ENV MONERO_VERSION=0.14.0.2 MONERO_SHA256=4dd5cd9976eda6b33b16821e79e671527b78a1c9bfb3d973efe84b824642dd21

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*
  
FROM ubuntu:18.04

RUN useradd -ms /bin/bash monero
WORKDIR /home/monero
RUN apt-get update  \
    && apt-get install -qqy nginx supervisor \
    && mkdir /supervisor \
    && rm -rf /etc/nginx/sites-enabled/default
USER monero
COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod
COPY supervisord.conf /supervisor/supervisord.conf
COPY conf/ /etc/nginx/conf.d/

# blockchain loaction
VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081

#ENTRYPOINT ["./monerod"]
#CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]

CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n

