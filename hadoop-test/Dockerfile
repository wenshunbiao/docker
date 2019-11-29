FROM centos
# install dev tools
RUN yum install -y curl which tar sudo openssh-server openssh-clients rsync bunzip2

# install hadoop nativelins tools
RUN yum install -y gcc gcc-c++ autoconf automake libtool zlib-devel cmake

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
    rpm -i jdk-7u51-linux-x64.rpm && \
    rm jdk-7u51-linux-x64.rpm

ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

# devel tools
RUN yum groupinstall "Development Tools" -y
RUN yum install -y cmake zlib-devel openssl-devel

# maven
ENV M2_VER=3.3.9
RUN curl http://www.eu.apache.org/dist/maven/maven-3/${M2_VER}/binaries/apache-maven-${M2_VER}-bin.tar.gz|tar xz  -C /usr/share
ENV M2_HOME /usr/share/apache-maven-${M2_VER}
ENV PATH $PATH:$M2_HOME/bin

RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2-src.tar.gz | tar -xz -C /tmp/

RUN yum install -y protobuf protobuf-c-devel fuse-devel fuse wget
RUN wget http://packages.psychotic.ninja/6/base/x86_64/RPMS//uncrustify-0.60-8.el6.psychotic.x86_64.rpm
RUN rpm -ivh uncrustify-0.60-8.el6.psychotic.x86_64.rpm
RUN wget https://github.com/remis-thoughts/native-hdfs-fuse/archive/master.zip
RUN unzip master.zip
RUN cd native-hdfs-fuse-master/ && sed -i "s#-Werror -Wall##g" Makefile && make && make install
RUN cd /tmp/hadoop-2.7.2-src && mvn package -Pdist,native -DskipTests -Dtar

RUN mv /tmp/hadoop-2.7.2-src/hadoop-dist/target/hadoop-2.7.2 /hadoop

ENV LD_LIBRARY_PATH /usr/local/lib
ENV export LD_RUN_PATH /usr/local/lib


RUN ln -s /usr/java/jdk1.7.0_51/jre/lib/amd64/server/libjvm.so /usr/local/lib/
RUN ln -s /tmp/hadoop-2.7.2-src/hadoop-hdfs-project/hadoop-hdfs/target/hadoop-hdfs-2.7.2/lib/native/* /usr/local/lib/
RUN ln -s /tmp/hadoop-2.7.2-src/hadoop-hdfs-project/hadoop-hdfs/target/native/main/native/fuse-dfs/fuse_dfs /usr/bin
RUN ln -s /tmp/hadoop-2.7.2-src/hadoop-hdfs-project/hadoop-hdfs/src/main/native/fuse-dfs/fuse_dfs_wrapper.sh /usr/bin/

RUN echo "export LD_LIBRARY_PATH=/usr/java/jdk1.7.0_51/jre/lib/amd64/server:/usr/local/lib" > /etc/profile
RUN echo "/usr/java/jdk1.7.0_51/jre/lib/amd64/server" >> /etc/ld.so.conf
RUN echo "/tmp/hadoop-2.7.2-src/hadoop-hdfs-project/hadoop-hdfs/target/hadoop-hdfs-2.7.2/lib/native" >> /etc/ld.so.conf
RUN /sbin/ldconfig -v

RUN mkdir /mnt/hdfs
#RUN echo "fuse_dfs_wrapper.sh dfs://192.168.1.11:54310 /mnt/hdfs    fuse rw,auto 0 0" >> /etc/fstab
#RUN modprobe fuse
RUN echo "fuse_dfs#dfs://coreos-test:9000 /mnt/hdfs fuse usetrash,rw 0 0" >> /etc/fstab
RUN ln -s /hadoop /usr/local/hadoop
RUN ln -s /usr/java/jdk1.7.0_51/ /opt/jdk
ENV JAVA_HOME /opt/jdk

ENV JAVA_HOME=/opt/jdk \
    HADOOP_VERSION=2.7.2 \
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

#RUN wget https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz
#RUN mv protobuf-2.5.0.tar.gz /tmp
#RUN cd /tmp && tar zxvf protobuf-2.5.0.tar.gz
#RUN cd /tmp/protobuf-2.5.0/ && ./configure
#RUN cd /tmp/protobuf-2.5.0/ && make && make install
#ENV LD_LIBRARY_PATH /usr/local/lib
#ENV export LD_RUN_PATH /usr/local/lib

#RUN wget https://github.com/protobuf-c/protobuf-c/releases/download/v1.0.0/protobuf-c-1.0.0.tar.gz
#RUN tar zxvf protobuf-c-1.0.0.tar.gz 
#RUN cd protobuf-c-1.0.0 && protobuf_LIBS=$(l=libprotobuf.a; for i in /opt/local/lib /usr/local/lib; do  if [ -f $i/$l ]; then echo $i/$l; fi; done) && \
#export protobuf_LIBS && \
#./configure && make && make install


#RUN tar -cv -C /tmp/hadoop-2.7.0-src/hadoop-dist/target/hadoop-2.7.0/lib/native/ .

