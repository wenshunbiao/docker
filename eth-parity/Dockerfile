FROM parity/parity:stable

USER root
RUN apt update
RUN apt -y install nginx
RUN apt -y install bash
RUN apt -y install vim

#RUN sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf

RUN apt -y install supervisor \
    && mkdir /supervisor

RUN rm -rf /etc/nginx/sites-enabled
RUN rm -rf /etc/nginx/sites-available

COPY conf/supervisord.conf /supervisor/supervisord.conf

RUN cat /supervisor/supervisord.conf

ENTRYPOINT []

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n

