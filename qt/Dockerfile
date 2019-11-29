FROM alpine

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk upgrade \
    && apk add --update \
alpine-sdk \
    qt5-qtbase qt5-qtmultimedia-dev qt5-qttools-dev \
    && rm -rf /var/cache/apk/*

