FROM debian:jessie

RUN apt-get update
RUN apt-get install -y samba

RUN rm -rf /var/lib/apt/lists/*
RUN touch /var/log/samba.log
RUN echo "samba.start" > /var/log/samba.log

WORKDIR /data

EXPOSE 139

CMD /etc/init.d/samba start && tail -f /var/log/samba.log
