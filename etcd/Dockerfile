FROM alpine:3.3

# install etcd
RUN ETCD_INSTALL_VERSION=v3.0.17 && apk add --update ca-certificates openssl tar && \
    wget https://github.com/coreos/etcd/releases/download/$ETCD_INSTALL_VERSION/etcd-$ETCD_INSTALL_VERSION-linux-amd64.tar.gz && \
    tar zxvf etcd-$ETCD_INSTALL_VERSION-linux-amd64.tar.gz && \
    mv etcd-$ETCD_INSTALL_VERSION-linux-amd64/etcd* /bin/ && \
    apk del --purge tar openssl && \
    rm -Rf etcd-$ETCD_INSTALL_VERSION-linux-amd64* /var/cache/apk/*

VOLUME /data
EXPOSE 2379 2380
