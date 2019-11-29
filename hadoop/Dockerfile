FROM ivories/java-oracle:1.0

RUN apk add --update openssh \
    rsync \
    jq \
    procps \
    coreutils \
    python \
    py-pip && \
    pip install supervisor && \
    rm -rf /var/cache/apk/*

ADD ssh/* /etc/ssh/

# passwordless ssh
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/id_rsa && \
    cp /etc/ssh/id_rsa.pub /etc/ssh/authorized_keys && \
    mkdir -p /root/.ssh && \
    cp /etc/ssh/ssh_config /root/.ssh/config && \
    cp /etc/ssh/authorized_keys /root/.ssh/authorized_keys && \
    cp /etc/ssh/id_rsa /root/.ssh/id_rsa && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/config && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/authorized_keys

ENV JAVA_HOME=/opt/jdk \
    HADOOP_VERSION=2.6.5 \
    HADOOP_PREFIX=/usr/local/hadoop \
    HADOOP_COMMON_HOME=/usr/local/hadoop \
    HADOOP_HDFS_HOME=/usr/local/hadoop \
    HADOOP_MAPRED_HOME=/usr/local/hadoop \
    HADOOP_YARN_HOME=/usr/local/hadoop \
    HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop \
    YARN_CONF_DIR=$HADOOP_PREFIX/etc/hadoop \
    YARN_IDENT_STRING=root \
    HADOOP_SSH_OPTS="-F /root/.ssh/config" \
    HADOOP_CLUSTERNAME=syracuse \
    HADOOP_ROLE=STANDALONE \
    HADOOP_HOME=/hadoop \
    CATALINA_OUT=/dev/stdout

# wrangle the pachyderm
RUN curl http://ftp.wayne.edu/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -o /tmp/hadoop-$HADOOP_VERSION.tar.gz && \
    tar zxvf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/ && \
    mv /usr/local/hadoop-$HADOOP_VERSION $HADOOP_PREFIX && \
    rm /tmp/hadoop-$HADOOP_VERSION.tar.gz && \
    sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/default\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && \
    sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && \
    mkdir $HADOOP_PREFIX/logs && \
    chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh && \
    mkdir $HADOOP_PREFIX/input && \
    cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input && \
    rm -rf /usr/local/hadoop/share/doc && \
    rm -rf /tmp/*

WORKDIR $HADOOP_PREFIX

USER root

RUN echo > /usr/local/hadoop/etc/hadoop/slaves

RUN ln -s /usr/local/hadoop /hadoop
RUN mkdir /usr/java
RUN ln -s /opt/jdk1.8.0_45 /usr/java/default

ADD etc/* /hadoop/etc/hadoop/
ADD entrypoint.sh /hadoop/entrypoint.sh

ENV PATH $PATH:/hadoop/bin

# HDFS ports
EXPOSE 9000 50010 50020 50070 50075 50090 14000
# MapReduce ports
EXPOSE 19888
# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
# Other ports
EXPOSE 49707 2122

CMD /hadoop/entrypoint.sh
