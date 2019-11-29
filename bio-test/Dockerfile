FROM ivories/bio:1.0

ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native \
    HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib" \
    LD_LIBRARY_PATH=/usr/local/hadoop/lib/native

RUN apk add --update --no-cache openssl-dev snappy-dev
ENV JAVA_LIBRARY_PATH=/hadoop/lib/native
ENV version 1.3.1

RUN cd /tmp && wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2 
RUN apk add --update --no-cache ncurses \
        && apk add --virtual=deps --update --no-cache ncurses-dev musl-dev g++ make zlib-dev \
        && cd /tmp/ && tar xjvf samtools-${version}.tar.bz2 \
        && cd /tmp/samtools-${version} && make \
        && mv /tmp/samtools-${version}/samtools /usr/bin \
        && rm -rf /var/cache/apk/* /tmp/* \
        && apk del deps

RUN apk add --update --no-cache build-base zlib-dev perl boost boost-dev 
#RUN mv /usr/bin/samtools /samtools

CMD /bin/bash
