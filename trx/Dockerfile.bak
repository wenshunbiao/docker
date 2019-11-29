FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    locale-gen en_US.UTF-8 && \
    apt-get dist-upgrade -y && \
    apt-get --purge remove openjdk* && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
    apt-get clean all

ENV TAG_BRANCH Odyssey-v3.5.0.1

# Install dependencies && Download java-tron
RUN apt-get update && apt-get install git -y
RUN git clone -b develop https://github.com/tronprotocol/java-tron.git tron \
    && cd /tron \
    && git fetch \
    && git fetch --tags \
    && git checkout $TAG_BRANCH

# Change work directory
WORKDIR /tron

# RUN ./gradlew lint
# RUN ./gradlew test
# RUN ./gradlew build
RUN ./gradlew clean shadowJar
