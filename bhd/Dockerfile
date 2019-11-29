FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -qqy wget
RUN wget https://www.btchd.org/package/bhd-v1.3.4.0-d909c0e-x86_64-linux-gnu.tar.gz \
    && tar -zvxf bhd-v1.3.4.0-d909c0e-x86_64-linux-gnu.tar.gz \
    && mv bhd-v1.3.4 bitcoinhd \
    && cp bitcoinhd/bin/* /usr/local/bin

ENV LD_LIBRARY_PATH /bitcoinhd/lib

EXPOSE 8732 
EXPOSE 8733

CMD btchdd -conf=/root/.btchd/btchd.conf
