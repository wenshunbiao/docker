FROM debian:sid-slim
FROM debian:jessie
COPY conf/init.sh /etc/init.sh

RUN apt-get update && apt-get -y install glusterfs-server glusterfs-client attr nfs-server&& \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV GLUSTERVOLNAME data

CMD ["/etc/init.sh"]
