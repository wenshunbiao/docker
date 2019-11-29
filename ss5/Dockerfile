from alpine

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update --no-cache dante-server@testing \
    && rm -rf /var/cache/apk/*

CMD sockd

