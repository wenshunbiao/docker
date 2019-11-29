FROM centos:7


RUN yum install -y build-essential wget e2fslibs-dev
RUN yum install -y gcc-c++
RUN yum install -y e2fsprogs-devel
RUN yum install -y bzip2
RUN wget https://nchc.dl.sourceforge.net/project/extundelete/extundelete/0.2.4/extundelete-0.2.4.tar.bz2
RUN tar -jxvf extundelete-0.2.4.tar.bz2
RUN yum install -y make
RUN cd extundelete-0.2.4 && ./configure && make && make install
RUN yum remove -y build-essential
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#FROM ubuntu:14.04

#RUN apt update && apt install -y build-essential wget e2fslibs-dev \
#    && wget https://nchc.dl.sourceforge.net/project/extundelete/extundelete/0.2.4/extundelete-0.2.4.tar.bz2 \
#    && tar -jxvf extundelete-0.2.4.tar.bz2 \
#    && cd extundelete-0.2.4 && ./configure && make && make install \
#    && apt remove -y build-essential wget && apt-get clean \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
