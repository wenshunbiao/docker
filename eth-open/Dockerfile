FROM openethereum/openethereum:v3.0.1

USER root
RUN apk add nginx
RUN apk add bash
RUN apk add vim

#RUN sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf

RUN apk add supervisor \
    && mkdir /supervisor

RUN rm -rf /etc/nginx/sites-enabled
RUN rm -rf /etc/nginx/sites-available

COPY conf/supervisord.conf /supervisor/supervisord.conf

RUN cat /supervisor/supervisord.conf

ENTRYPOINT []

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n

