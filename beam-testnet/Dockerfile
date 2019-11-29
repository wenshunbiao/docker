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

RUN cd / \
    && git clone https://github.com/BeamMW/beam.git 
RUN export PATH="$PATH:/opt/qt511/bin" \
    && cp -r beam beam-master \
    && cd beam-master \
#    && git checkout -b master origin/master  \
    && echo "Making..." \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBEAM_NO_QT_UI_WALLET=no . \
    && make -j4 \
    && cd / \
    && cp -r beam beam-testnet \
    && cd beam-testnet \
    && git checkout -b testnet origin/testnet  \
    && echo "Making..." \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBEAM_NO_QT_UI_WALLET=no . \
    && make -j4 \
    && cd / \
    && cp -r beam beam-testnet2 \
    && cd beam-testnet2 \
    && git checkout -b testnet2 origin/testnet2  \
    && echo "Making..." \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBEAM_NO_QT_UI_WALLET=no . \
    && make -j4 \
    && cd / \
    && cp -r beam beam-testnet3 \
    && cd beam-testnet3 \
    && git checkout -b testnet3 origin/testnet3  \
    && echo "Making..." \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBEAM_NO_QT_UI_WALLET=no . \
    && make -j4 \
    && cd / \
    && cp -r beam beam-testnet4 \
    && cd beam-testnet4 \
    && git checkout -b testnet4 origin/testnet4  \
    && echo "Making..." \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBEAM_NO_QT_UI_WALLET=no . \
    && make -j4 

#RUN cp -r /beam/beam/beam-node /usr/bin/  \
#    && cp -r /beam/wallet/beam-wallet /usr/bin/

RUN apt-get install -y  supervisor nginx \
    && mkdir /supervisor \
#    && sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf \
    && rm -rf /etc/nginx/sites-enabled/default 

COPY supervisord.conf /supervisor/supervisord.conf

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n
   




