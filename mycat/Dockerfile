FROM openjdk:8-jdk-stretch

ENV MYCAT_URL http://dl.mycat.org.cn/1.6.7.4/Mycat-server-1.6.7.4-release/Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz

ADD $MYCAT_URL /usr/local
RUN cd /usr/local && tar -zxf Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz && rm Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz && ls -lna

VOLUME /usr/local/mycat/conf
VOLUME /usr/local/mycat/logs

WORKDIR /usr/local/mycat

EXPOSE 8066 9066

CMD ["/usr/local/mycat/bin/mycat", "console"]
