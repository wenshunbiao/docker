FROM debian:jessie-slim

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https wget apt-utils && \
    wget -qO - https://apt.z.cash/zcash.asc | apt-key add - && \
    echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y zcash=1.1.2
        
#RUN DEBIAN_FRONTEND=noninteractive apt-get remove -y apt-transport-https wget apt-utils && \
#    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

VOLUME ["/home/zcash"]
HEALTHCHECK --interval=5m --timeout=3s \
    CMD zcash-cli getinfo || exit 1
EXPOSE 8233

USER root

COPY start.sh /usr/bin/zec
RUN chmod -R 777 /usr/bin/zec
#ENTRYPOINT ["zec"]
ENTRYPOINT [""]

