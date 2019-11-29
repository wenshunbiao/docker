FROM ivories/hadoop:1.0

#RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories

ARG SPARK_VERSION=1.6.3
ARG SPARK_HADOOP_VERSION=2.6
ARG TAR=spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz

ENV PATH $PATH:/spark/bin

LABEL Description="Apache Spark" \
      "Spark Version"="$SPARK_VERSION"

WORKDIR /

RUN cd /usr/local && apk add --no-cache bash openjdk8-jre-base wget tar && \
    wget -t 100 --retry-connrefused -O "${TAR}" "http://d3kbcqa49mib13.cloudfront.net/${TAR}" && \
    tar zxf "${TAR}" && \
    rm -fv "${TAR}" && \
    mv "spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION" /usr/local/spark && \
    ln -s /usr/local/spark /spark && \
    apk del wget tar && rm -rf /var/cache/apk/*

RUN cp -v /spark/conf/spark-env.sh.template /spark/conf/spark-env.sh

EXPOSE 4040 7077 8080 8081

COPY entrypoint.sh /spark/
CMD /spark/entrypoint.sh
