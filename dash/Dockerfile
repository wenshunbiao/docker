FROM  ubuntu:18.04  

ENV BRANCH=0.13.3
ENV IS=x86_64
RUN apt-get update \
    && apt-get install wget -y  \
    && wget "https://github.com/dashpay/dash/releases/download/v${BRANCH}.0/dashcore-${BRANCH}.0-${IS}-linux-gnu.tar.gz" \
    && tar -zxvf dashcore-${BRANCH}.0-${IS}-linux-gnu.tar.gz  \
    && mv dashcore-${BRANCH} dashcore 

CMD /dashcore/bin/dashd 
