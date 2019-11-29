FROM dorowu/ubuntu-desktop-lxde-vnc

RUN apt update && apt install -y cmake git mpich mpich-doc libx11-dev && \
    git clone https://github.com/3dem/relion.git && cd relion && mkdir build && \
    cd build && cmake -DCMAKE_INSTALL_PREFIX=/where/to/install/ .. && make -j4 && make install && \
    apt remove -y cmake libx11-dev

ENTRYPOINT ["/startup.sh"]
