#!/bin/bash
IS_MASTER=1

if [ "" = "$MASTER_HOSTNAME" ]; then
    MASTER_HOSTNAME=$HOSTNAME
fi

if [ "$MASTER_HOSTNAME" != "$HOSTNAME" ]; then
    HOSTNAME=$MASTER_HOSTNAME
    IS_MASTER=0
fi

cd /hadoop/etc/hadoop
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" core-site.xml
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" hdfs-site.xml
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" mapred-site.xml
sed -i "s/HOSTNAME_HADOOP/${HOSTNAME}/g" yarn-site.xml

if [ ! -d "/data/hdfs" ]; then
    mkdir /data/hdfs && chown -R hduser:hadoop /data/hdfs
    if [ $IS_MASTER -eq 1 ]; then
        hdfs namenode -format
    else
        hdfs datanode -format
    fi
fi

if [ $IS_MASTER -eq 1 ]; then
    /usr/sbin/sshd
    /hadoop/sbin/start-dfs.sh
    /hadoop/sbin/start-yarn.sh
fi

/hadoop/sbin/hadoop-daemon.sh start datanode
/hadoop/sbin/yarn-daemon.sh start nodemanager

tail -f /hadoop/logs/*
