FROM alpine

RUN apk --update add build-base
RUN wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
RUN tar xjvf vim-7.3.tar.bz2

RUN apk add ncurses-dev

RUN apk add curl
RUN curl -o Python-2.7.11.tar.xz https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tar.xz 
RUN tar xJvf Python-2.7.11.tar.xz

RUN apk add libbz2 expat libffi gdbm ncurses-terminfo-base ncurses-terminfo ncurses-libs readline sqlite-libs

RUN cd Python-2.7.11 && ./configure --prefix=/python2.7 && make && make install

RUN apk add bash

RUN apk add python python-dev

RUN cd vim73 && ./configure --prefix=/opt/vim --enable-pythoninterp --with-python-config-dir=/python2.7/lib/python2.7/config

RUN cd vim73 && make && make install

CMD bash
