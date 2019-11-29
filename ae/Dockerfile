FROM aeternity/aeternity
USER root
RUN apt-get update  \
    && apt-get install -qqy nginx supervisor \
    && mkdir /supervisor \
    && rm -rf /etc/nginx/sites-enabled/default

COPY supervisord.conf /supervisor/supervisord.conf
COPY conf/conf.d /etc/nginx/conf.d

ENTRYPOINT [ "" ]

CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n
