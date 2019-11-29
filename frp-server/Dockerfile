FROM alpine:3.7

ENV FRP_VERSION 0.21.0

RUN wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \ 
    tar xzf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
    cd frp_${FRP_VERSION}_linux_amd64 && \
    mv frps /frps && \
    mv frpc /frpc && \
    mv frps.ini /frps.ini && \
    mv frpc.ini /frpc.ini && \
    cd .. && \
    rm -rf *.tar.gz && \
    rm -rf frp_${FRP_VERSION}_linux_amd64

WORKDIR /

ENTRYPOINT [""]
CMD /frps -c /frps.ini
