# Note: The newer busybox:glibc is missing libpthread.so.0.
FROM alpine

ENV NGROK_DOMAIN=your-domain-name.com

RUN apk add --no-cache wget build-base curl go git openssl openssl-dev&& \
    curl -o ngrok-1.7.1.tar.gz https://codeload.github.com/inconshreveable/ngrok/tar.gz/1.7.1 && \
    tar zxvf ngrok-1.7.1.tar.gz && cd ngrok-1.7.1 && \
    openssl genrsa -out rootCA.key 2048 && \
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem && \
    openssl genrsa -out device.key 2048 && \
    openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr && \
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000 && \
    cp rootCA.pem assets/client/tls/ngrokroot.crt -f && \
    cp device.crt assets/server/tls/snakeoil.crt -f && \
    cp device.key assets/server/tls/snakeoil.key -f && \
    sed -i "s#code.google.com/p#github.com/alecthomas#g" ./src/ngrok/log/logger.go && \
    make release-server  && GOOS=linux GOARCH=amd64 make release-client && \
    mv /ngrok-1.7.1/bin/ngrok* /usr/bin/ && \
    rm -rf /ngrok-1.7.1* && \
    apk del wget build-base curl go git openssl openssl-dev && rm -rf /var/cache/apk/*

CMD ngrok 80
