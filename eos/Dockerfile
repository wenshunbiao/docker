FROM ubuntu:18.04

ARG branch=1.6.2

RUN apt-get update && apt-get install -qqy wget supervisor \
    && wget https://github.com/EOSIO/eos/releases/download/v${branch}/eosio_${branch}-1-ubuntu-18.04_amd64.deb \
    && apt-get install -qqy  ./eosio_${branch}-1-ubuntu-18.04_amd64.deb \
    && mkdir -p  /supervisor 
RUN apt-get install -qqy nginx net-tools curl cron \
    && rm -rf /etc/nginx/sites-enabled/default

COPY crontabfile /etc/cron.d/cron

COPY conf/conf.d /etc/nginx/conf.d

COPY supervisord.conf /supervisor

COPY nodeos.sh /nodeos.sh

COPY snapshot.sh /snapshot.sh

RUN chmod +x /nodeos.sh \
    && chmod +x /snapshot.sh \
    && chmod 0644 /etc/cron.d/cron \
    && crontab /etc/cron.d/cron
 
CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n    
