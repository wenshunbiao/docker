FROM alpine:3.3

RUN ALPINE_GLIBC_VERSION="latest" && \
    ALPINE_GLIBC_REPO="sgerrand" && \
    ALPINE_GLIBC_PROJ="alpine-pkg-glibc" && \
    DOCKERIZE_VERSION="latest" && \
    DOCKERIZE_REPO="jwilder" && \
    DOCKERIZE_PROJ="dockerize" && \
    apk add --update -t deps wget ca-certificates curl bash && \
    cd /tmp && \
    wget $(curl -s https://api.github.com/repos/$ALPINE_GLIBC_REPO/$ALPINE_GLIBC_PROJ/releases/$ALPINE_GLIBC_VERSION | grep 'browser_' | egrep 'glibc-.*.apk' | cut -d\" -f4) && \
    apk add --allow-untrusted glibc-*.apk && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    wget $(curl -s https://api.github.com/repos/$DOCKERIZE_REPO/$DOCKERIZE_PROJ/releases/$DOCKERIZE_VERSION | grep 'browser_' | egrep 'amd64-.*.tar.gz' | cut -d\" -f4) && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-v0.3.0.tar.gz && \
    apk del --purge deps glibc-i18n && \
    apk add --update wget ca-certificates curl bash && \
    rm -rf /tmp/* /var/cache/apk/*
