FROM rust

RUN sed -i 's@http://deb.debian.org@http://mirrors.163.com@g' /etc/apt/sources.list
RUN sed -i 's@http://security.debian.org@http://mirrors.163.com@g' /etc/apt/sources.list

RUN apt update
RUN apt install -y musl-dev perl bash golang bzr git mercurial subversion openssh-client ca-certificates
RUN apt install -y cmake

RUN apt install -y pkg-config libssl-dev clang libclang-dev

RUN curl -OL https://github.com/google/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip
RUN unzip protoc-3.6.1-linux-x86_64.zip -d protoc3
RUN mv protoc3/bin/* /usr/bin/
RUN mv protoc3/include/* /usr/include/
