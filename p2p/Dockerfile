FROM davidcaste/alpine-tomcat:jdk7tomcat8

RUN apk add --no-cache curl tar bash

ARG MAVEN_VERSION=3.5.2
ARG USER_HOME_DIR="/root"
ARG SHA=707b1f6e390a65bde4af4cdaf2a24d45fc19a6ded00fff02e91626e3e42ceaff
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN curl -fsSL -o /usr/local/bin/mvn-entrypoint.sh https://raw.githubusercontent.com/carlossg/docker-maven/93d297ed2fc952af8c3638eae78c3d5e7526033f/jdk-7-alpine/mvn-entrypoint.sh
RUN curl -fsSL -o /usr/share/maven/ref/settings-docker.xml https://raw.githubusercontent.com/carlossg/docker-maven/93d297ed2fc952af8c3638eae78c3d5e7526033f/jdk-7-alpine/settings-docker.xml

VOLUME "$USER_HOME_DIR/.m2"

RUN apk add --no-cache git
