FROM  ubuntu:18.04  

RUN apt-get update
RUN apt-get install g++-7 libboost-all-dev libssl-dev wget git -y  \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7 \
    && update-alternatives --config gcc \
    && wget "https://cmake.org/files/v3.12/cmake-3.12.0-Linux-x86_64.sh" \
    && sh cmake-3.12.0-Linux-x86_64.sh --skip-license --prefix=/usr 
RUN apt-get install software-properties-common -y \
    && add-apt-repository ppa:beineri/opt-qt-5.11.0-bionic \
    && apt-get update \
    && apt-get install qt511declarative qt511svg libgl1-mesa-dev libglu1-mesa-dev -y 
ENV BRANCH="mainnet"
RUN cd / \ 
    && git clone https://github.com/BeamMW/beam.git \
    && export PATH="$PATH:/opt/qt511/bin" \
    && cd /beam \
    && git checkout -b $BRANCH origin/$BRANCH \
    && echo "Making..." \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBEAM_NO_QT_UI_WALLET=on . \
    && make -j4 

#FROM ubuntu:18.04
#COPY --from=0 /beam/beam/beam-node /usr/bin/
#COPY --from=0 /beam/wallet/beam-wallet /usr/bin/
#COPY --from=0 /beam/beam/beam-node.cfg /beam/
#COPY --from=0 /beam/wallet/beam-wallet.cfg /beam/

RUN apt-get install -y  supervisor nginx \
    && mkdir /supervisor \
#    && sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf \
    && rm -rf /etc/nginx/sites-enabled/default 

COPY supervisord.conf /supervisor/supervisord.conf
COPY conf/ /etc/nginx/
CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n

   




