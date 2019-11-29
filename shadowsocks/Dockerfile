FROM alpine

MAINTAINER Acris Liu "https://github.com/Acris/docker-shadowsocks-libev"

ENV SHADOWSOCKS_LIBEV_VERSION v3.1.0
ENV SIMPLE_OBFS_VERSION v0.0.3

# Build shadowsocks-libev and simple-obfs
RUN set -ex \

    # Install dependencies
    && apk add --no-cache --virtual .build-deps \
               autoconf \
               automake \
               build-base \
               libev-dev \
               libtool \
               linux-headers \
               udns-dev \
               libsodium-dev \
               mbedtls-dev \
               pcre-dev \
               tar \
               udns-dev \
               git \
               c-ares-dev \
    # Build shadowsocks-libev
    && mkdir -p /tmp/build-shadowsocks-libev \
    && cd /tmp/build-shadowsocks-libev \
    && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
    && cd shadowsocks-libev \
    && git checkout "$SHADOWSOCKS_LIBEV_VERSION" \
    && git submodule update --init --recursive \
    && ./autogen.sh \
    && ./configure --disable-documentation \
    && make install \
    && ssRunDeps="$( \
        scanelf --needed --nobanner /usr/local/bin/ss-server \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --no-cache --virtual .ss-rundeps $ssRunDeps \
    && cd / \
    && rm -rf /tmp/build-shadowsocks-libev \

    # Build simple-obfs
    && mkdir -p /tmp/build-simple-obfs \
    && cd /tmp/build-simple-obfs \
    && git clone https://github.com/shadowsocks/simple-obfs.git \
    && cd simple-obfs \
    && git checkout "$SIMPLE_OBFS_VERSION" \
    && git submodule update --init --recursive \
    && ./autogen.sh \
    && ./configure --disable-documentation \
    && make install \
    && simpleObfsRunDeps="$( \
        scanelf --needed --nobanner /usr/local/bin/obfs-server \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --no-cache --virtual .simple-obfs-rundeps $simpleObfsRunDeps \
    && cd / \
    && rm -rf /tmp/build-simple-obfs \
    
    # Delete dependencies
    && apk del .build-deps


