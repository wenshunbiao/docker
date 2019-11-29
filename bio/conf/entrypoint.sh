#!/bin/bash
chown -R root:root /hadoop

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

sed -i "s#<value>1</value>#<value>4</value>#g" hdfs-site.xml
#sed -i "s#</configuration>#<property><name>dfs.balance.bandwidthPerSec</name><value>10485760</value></property></configuration>#g" hdfs-site.xml

#sed -i "s#</configuration>#<property><name>yarn.nodemanager.aux-services.spark_shuffle.class</name><value>org.apache.spark.network.yarn.YarnShuffleService</value></property></configuration>#g" yarn-site.xml
#sed -i "s/mapreduce_shuffle/spark_shuffle/g" yarn-site.xml

LOCAL_AREA_IP=`hostname`
addgroup supergroup
mkdir /tmp/.hdfs-nfs
sed -i "s#</configuration>#<property><name>hadoop.proxyuser.root.groups</name><value>root</value></property><property><name>hadoop.proxyuser.root.hosts</name><value>*</value></property></configuration>#g" core-site.xml
sed -i "s#</configuration>#<property><name>dfs.namenode.accesstime.precision</name><value>36000000</value></property></configuration>#g" hdfs-site.xml
sed -i "s#</configuration>#<property><name>nfs.dump.dir</name><value>/tmp/.hdfs-nfs</value></property></configuration>#g" core-site.xml
sed -i "s#</configuration>#<property><name>nfs.dump.dir</name><value>/tmp/.hdfs-nfs</value></property></configuration>#g" hdfs-site.xml
sed -i "s#</configuration>#<property><name>nfs.exports.allowed.hosts</name><value>* rw</value></property></configuration>#g" hdfs-site.xml


if [ ! -d "/data/hdfs" ]; then
    mkdir /data/hdfs && chown -R hduser:hadoop /data/hdfs
    if [ "$IS_MASTER" == "" ]; then
        hdfs namenode -format
    else
        hdfs datanode -format
    fi
fi

/usr/sbin/sshd

if [ "$IS_MASTER" == "" ]; then
    /hadoop/sbin/start-dfs.sh
    /hadoop/sbin/start-yarn.sh
    /spark/sbin/start-master.sh
#    /spark/sbin/start-history-server.sh hdfs://master:9000/spark-history
fi


CPUS=$(cat /proc/cpuinfo | grep processor | sed -n "\$p" | awk '{print $3+1}')
MEMS=$(free -g |sed -n '2p' |awk '{print $2}')
CAN_USE_CPUS=$(expr $CPUS \* 3 / 4 )
CAN_USE_MEMS=$(expr $MEMS \* 3 / 4 ) 
echo "
##################################
SPARK_WORKER_INSTANCES=1
SPARK_WORKER_CORES=${CAN_USE_CPUS}
#SPARK_WORKER_CORES=40
SPARK_WORKER_MEMORY=${CAN_USE_MEMS}G
#SPARK_DAEMON_MEMORY=2G
##################################
" >> /spark/conf/spark-env.sh

echo "
spark.driver.maxResultSize	 5120M
spark.master                     spark://master:7077
spark.eventLog.enabled           true
spark.eventLog.dir               hdfs://master:9000/event
" > /spark/conf/spark-defaults.conf 

/spark/sbin/start-slave.sh ${HOSTNAME}:7077
/hadoop/sbin/hadoop-daemon.sh start datanode
/hadoop/sbin/yarn-daemon.sh start nodemanager

/hadoop/sbin/hadoop-daemon.sh --script /hadoop/bin/hdfs start portmap
/hadoop/sbin/hadoop-daemon.sh --script /hadoop/bin/hdfs start nfs3

mkdir /hdfs-nfs
while [ 1 ]
do
    sleep 5s
    data=$(df -t nfs | grep "hdfs-nfs")
    if [ "$data" == "" ]
    then
        mount -t nfs -o nolock,vers=3,tcp,retry=1 $LOCAL_AREA_IP:/ /hdfs-nfs/
    fi
done
