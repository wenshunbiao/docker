FROM ethereum/client-go:v1.9.0

RUN apk add --no-cache nginx
RUN apk add --no-cache bash
RUN sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf

RUN apk add --no-cache curl wget

RUN apk add --no-cache supervisor \
    && mkdir /supervisor

COPY conf/supervisord.conf /supervisor/supervisord.conf

RUN cat /supervisor/supervisord.conf

ENTRYPOINT []

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n



