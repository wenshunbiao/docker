FROM php:7.2.34-fpm-alpine

ENV SWOOLE_VERSION 4.4.15

RUN apk add --no-cache bash autoconf build-base \
    && apk add --no-cache bash wget libpng-dev libmcrypt-dev libstdc++ libevent-dev \
    && docker-php-ext-install gd mysqli pdo_mysql bcmath opcache pcntl zip \
    && pecl install redis \
    && pecl install xdebug \
    && pecl install channel://pecl.php.net/mcrypt-1.0.1 \

    && apk add --no-cache freetype-dev jpeg-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \

    && apk add --no-cache libssh2-dev \
    && wget http://pecl.php.net/get/ssh2-1.1.2.tgz \
    && tar zxvf ssh2-1.1.2.tgz && cd ssh2-1.1.2 && phpize && ./configure --with-ssh2 && make \
    && mv modules/ssh2.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718 \
    && cd .. && rm -rf ssh2-1.1.2* \

    && wget https://github.com/yunnian/php-nsq/archive/v3.2.0.tar.gz \
    && tar zxvf v3.2.0.tar.gz && cd php-nsq-3.2.0 && phpize && ./configure && make && make install \
    && cd .. && rm -rf v3.2.0.tar.gz php-nsq-3.2.0 \

    && wget https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz \
    && tar zxvf v${SWOOLE_VERSION}.tar.gz && cd swoole-src-${SWOOLE_VERSION} && cp -a /usr/include/openssl /var/www/html/swoole-src-${SWOOLE_VERSION}/include && phpize \
    && ./configure --enable-http2 --enable-mysqlnd --enable-openssl --with-openssl-dir=/usr/include/openssl \
    && make && make install \
    && cd .. && rm -rf v${SWOOLE_VERSION}.tar.gz swoole-src-${SWOOLE_VERSION} \

    && apk del build-base autoconf libstdc++ libevent-dev 

RUN echo "export TERM=xterm" >> /root/.bashrc \
    && rm -rf /usr/local/etc/php-fpm.conf \
    && mkdir /php \
    && ln -s /php/php.ini /usr/local/etc/php/php.ini \
    && ln -s /php/php-fpm.conf /usr/local/etc/php-fpm.conf

RUN apk add --no-cache git

WORKDIR /www

CMD php-fpm
