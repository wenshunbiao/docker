FROM alpine

RUN apk add --no-cache build-base autoconf

RUN wget https://github.com/g2p/bcache-tools/archive/v1.0.8.tar.gz

RUN tar zxvf v1.0.8.tar.gz

RUN apk add --no-cache util-linux-dev linux-headers

RUN mkdir /lib/udev && mkdir /lib/udev/rules.d && mkdir /usr/share/man/man8


RUN cd bcache-tools-1.0.8 && sed -i 's/inline uint64_t/uint64_t/g' bcache.c &&  make && make install
