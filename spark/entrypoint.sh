#!/bin/bash
if [ "" = "$MASTER_HOSTNAME" ]; then
    MASTER_HOSTNAME=$HOSTNAME
fi

if [ "$MASTER_HOSTNAME" != "$HOSTNAME" ]; then
    HOSTNAME=$MASTER_HOSTNAME
    IS_MASTER="no"
fi

cd /hadoop/etc/hadoop
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" core-site.xml
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" hdfs-site.xml
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" mapred-site.xml
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" yarn-site.xml

if [ ! -d "/data/hdfs" ]; then
    mkdir /data/hdfs && chown -R hduser:hadoop /data/hdfs
    if [ "$IS_MASTER" == "" ]; then
        hdfs namenode -format
    else
        hdfs datanode -format
    fi
fi

if [ "$IS_MASTER" == "" ]; then
    /usr/sbin/sshd
    /hadoop/sbin/start-dfs.sh
    /hadoop/sbin/start-yarn.sh
    /spark/sbin/start-master.sh
fi

/spark/sbin/start-slave.sh ${HOSTNAME}:7077
/hadoop/sbin/hadoop-daemon.sh start datanode
/hadoop/sbin/yarn-daemon.sh start nodemanager

tail -f /spark/logs/*

#export SPARK_DAEMON_MEMORY="${SPARK_DAEMON_MEMORY:-128M}"
#export SPARK_HOME="/spark"
