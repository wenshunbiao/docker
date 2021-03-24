FROM hyperf/hyperf:7.4-alpine-v3.11-swoole

RUN wget https://github.com/composer/composer/releases/download/1.8.6/composer.phar
RUN chmod u+x composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer

WORKDIR /www

CMD tail -f /dev/null
