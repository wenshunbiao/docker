FROM alpine


RUN apk --update --no-progress add git curl php-cli php-json php-phar php-openssl \
    && wget https://github.com/clue/psocksd/archive/v0.3.5.tar.gz && tar zxvf v0.3.5.tar.gz \
    && cd psocksd-0.3.5 && curl -s https://getcomposer.org/installer | php && php composer.phar install \
    && apk del git curl && rm -rf /var/cache/apk/* && rm -rf v0.3.5.tar.gz

CMD ls
#CMD php psocksd/bin/psocksd socks5://test:test@*:9050
