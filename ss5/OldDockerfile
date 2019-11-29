FROM debian:jessie

RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y libpam0g-dev
RUN apt-get install -y libldap2-dev
RUN apt-get install -y openssl
RUN apt-get install -y libpcap-dev
RUN apt-get install -y libssl-dev
RUN rm -rf /var/lib/apt/lists/*

COPY ss5-3.8.9.tar.gz /ss5-3.8.9.tar.gz
RUN tar zxvf ss5-3.8.9.tar.gz && cd /ss5-3.8.9 && make install && rm -rf /ss5-3.8.9

RUN touch /etc/opt/ss5/ss5.passwd
RUN touch /etc/opt/ss5/ss5.ha

COPY conf/ss5.conf /etc/opt/ss5/ss5.conf

EXPOSE 18080

CMD /usr/sbin/ss5 -t -b 0.0.0.0:18080 && /usr/bin/tail -f /var/log/ss5/ss5.log
