# Multistage docker build, requires docker 17.05

# builder stage
FROM rust:1.31 as builder

RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
    clang \
    libclang-dev \
    llvm-dev \
    libncurses5 \
    libncursesw5 \
    cmake \
    git

WORKDIR /usr/src/grin

# Copying Grin
RUN git clone https://github.com/mimblewimble/grin.git

# Building Grin
RUN cd grin && cargo build --release

#RUN cd ../ \
#    && git clone https://github.com/mimblewimble/grin-wallet.git \
#    && cd grin-wallet && cargo build --release

#CMD [""]

# runtime stage
FROM debian:9.4

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales openssl nginx supervisor curl\
    && mkdir /supervisor \
#    && rm -rf /etc/nginx/sites-enabled/default
    && rm -rf /etc/nginx/sites-available \
    && rm -rf /etc/nginx/sites-enabled

COPY --from=builder /usr/src/grin/grin/target/release/grin /usr/local/bin/grin
#COPY --from=builder /usr/src/grin/grin-wallet/target/release/grin-wallet /usr/local/bin/grin-wallet

RUN apt-get install -qqy screen htop net-tools && \
    curl -OL -e '; auto' --url https://github.com/mimblewimble/grin-wallet/releases/download/v1.1.0-beta.4/grin-wallet-v1.1.0-beta.4-linux-amd64.tar.gz  && \
    tar -xvf grin-wallet-v1.1.0-beta.4-linux-amd64.tar.gz && \
    rm -r grin-wallet-v1.1.0-beta.4-linux-amd64.tar.gz && \
    mv grin-wallet/grin-wallet /usr/local/bin/ && \
    grin server config && \
    sed -i -e 's/run_tui = true/run_tui = false/' grin-server.toml && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8    
    
COPY supervisord.conf /supervisor/supervisord.conf

COPY conf/conf.d /etc/nginx/conf.d

COPY conf/start.sh /wallet.sh

WORKDIR /root/.grin

VOLUME ["/root/.grin"]

EXPOSE 3413 3414 3415 3416

#ENTRYPOINT ["grin"]

#CMD ["server", "run"]

CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n
