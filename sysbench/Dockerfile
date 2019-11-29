FROM alpine

RUN wget https://github.com/akopytov/sysbench/archive/1.0.15.tar.gz \
    && apk add bash build-base autoconf automake libtool \
    && tar zxvf 1.0.15.tar.gz \
    && cd sysbench-1.0.15 && ./autogen.sh && ./configure --without-mysql && make && make install \
    && cd / && rm -rf 1.0.15.tar.gz sysbench-1.0.15 && apk del build-base autoconf automake && apk add libgcc
