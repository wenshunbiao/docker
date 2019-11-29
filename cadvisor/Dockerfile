FROM alpine:3.3

ENV CADVISOR_VERSION 0.23.4

ARG GLIBC_VERSION=2.23-r3
RUN apk --no-cache add ca-certificates wget \
 && wget -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
 && apk add glibc-2.23-r3.apk --no-cache \
 && rm glibc-2.23-r3.apk \
 && rm /etc/apk/keys/sgerrand.rsa.pub \
 && wget https://github.com/google/cadvisor/releases/download/v${CADVISOR_VERSION}/cadvisor -o /usr/bin/cadvisor \
 && chmod +x /usr/bin/cadvisor \
 && apk del wget ca-certificates --no-cache


EXPOSE 8080

ENTRYPOINT ["cadvisor", "-logtostderr"]
