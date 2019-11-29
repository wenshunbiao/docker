FROM  ubuntu:18.04  

RUN apt-get update && apt-get install -y wget supervisor nginx \
    && mkdir /supervisor \
    && rm -rf /etc/nginx/sites-enabled/default \
    && mkdir -p /beam \
    && mkdir -p /beam/wallet \
    && mkdir -p /beam/node 

RUN wget https://builds.beam.mw/mainnet/2019.04.03/Release/linux/beam-wallet-cli-2.0.4739.tar.gz \
    && wget https://builds.beam.mw/mainnet/2019.04.03/Release/linux/beam-node-2.0.4739.tar.gz \ 
    && tar -zxvf beam-wallet-cli-2.0.4739.tar.gz -C /beam/wallet \
    && tar -zxvf beam-node-2.0.4739.tar.gz -C /beam/node \
    && rm -rf beam-* 
        
COPY conf/conf.d /etc/nginx/conf.d

COPY supervisord.conf /supervisor/supervisord.conf

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n
