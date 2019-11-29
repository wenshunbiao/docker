FROM christoefar/siacoin-docker

RUN apt update && apt install -y nginx supervisor \
    && mkdir /supervisor \
#    && sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf \
    && rm -rf /etc/nginx/sites-enabled/default

COPY supervisord.conf /supervisor/supervisord.conf

COPY conf/ /etc/nginx/conf.d/

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n

#CMD ["/usr/local/bin/siad"]
