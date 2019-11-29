FROM tomcat:8.0.47-jre7-alpine

RUN ALPINE_GLIBC_VERSION="latest" && \
    ALPINE_GLIBC_REPO="sgerrand" && \
    ALPINE_GLIBC_PROJ="alpine-pkg-glibc" && \
    DOCKERIZE_VERSION="latest" && \
    DOCKERIZE_REPO="jwilder" && \
    DOCKERIZE_PROJ="dockerize" && \
    apk add --update -t deps wget ca-certificates curl bash && \
    cd /tmp && \
    wget $(curl -s https://api.github.com/repos/$ALPINE_GLIBC_REPO/$ALPINE_GLIBC_PROJ/releases/$ALPINE_GLIBC_VERSION | grep 'browser_' | egrep 'glibc-.*.apk' | cut -d\" -f4) && \
    apk add --allow-untrusted glibc-*.apk && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    wget $(curl -s https://api.github.com/repos/$DOCKERIZE_REPO/$DOCKERIZE_PROJ/releases/$DOCKERIZE_VERSION | grep 'browser_' | egrep 'amd64-.*.tar.gz' | cut -d\" -f4) && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-v*.tar.gz && \
    apk del --purge deps glibc-i18n && \
    apk add --update wget ca-certificates curl bash && \
    rm -rf /tmp/* /var/cache/apk/*

ARG MAVEN_VERSION=3.5.0
ARG USER_HOME_DIR="/root"
ARG SHA=beb91419245395bd69a4a6edad5ca3ec1a8b64e41457672dc687c173a495f034
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

COPY settings-docker.xml /usr/share/maven/ref/


#RUN apk add --no-cache 

