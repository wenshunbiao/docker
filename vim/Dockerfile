FROM alpine

RUN apk --update add build-base curl python-dev python ncurses-dev \
    && curl -o Python-2.7.11.tar.xz https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tar.xz \
    && wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2 \
    && tar xJvf /Python-2.7.11.tar.xz \
    && cd /Python-2.7.11 && ./configure --prefix=/python2.7 && make && make install \
    && cd / && tar xjvf vim-7.3.tar.bz2 \
    && cd /vim73 && ./configure --prefix=/opt/vim --enable-pythoninterp --with-python-config-dir=/python2.7/lib/python2.7/config \
    && make && make install \
    && cd / && rm -rf Python-2.7.11* vim* \
    && apk del build-base curl python-dev \
    && rm -rf /var/cache/apk/*

CMD /opt/vim/bin/vim


