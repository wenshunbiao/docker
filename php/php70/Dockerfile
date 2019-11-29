FROM php:7.0-fpm-alpine3.7

RUN apk add --no-cache libpng-dev bash autoconf build-base \
    && docker-php-ext-install gd mysqli pdo_mysql bcmath opcache \
    && pecl install redis \
    && pecl install xdebug \
    && pecl install swoole \
    && apk del build-base autoconf

RUN apk add --no-cache imagemagick-dev

RUN apk update && apk add autoconf build-base
RUN pecl install imagick

RUN apk add freetype freetype-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
