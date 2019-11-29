FROM centos:6.8


RUN yum install -y build-essential wget e2fslibs-dev
RUN yum install -y gcc-c++
RUN yum install -y e2fsprogs-devel
RUN wget https://nchc.dl.sourceforge.net/project/extundelete/extundelete/0.2.4/extundelete-0.2.4.tar.bz2
RUN tar -jxvf extundelete-0.2.4.tar.bz2
RUN cd extundelete-0.2.4 && ./configure && make && make install
RUN yum remove -y build-essential
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



