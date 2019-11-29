FROM node:8.11-alpine

ARG VERSION=4.0.0-alpha.6

LABEL version=$VERSION

RUN npm install --global gitbook-cli && \
    gitbook fetch ${VERSION} && \
    npm cache clear --force && \
    rm -rf /tmp/* && \
    apk add --no-cache wget ca-certificates

RUN wget --no-check-certificate https://codeload.github.com/rootsongjc/kubernetes-handbook/zip/master && \
    unzip master && \
    rm -rf master && \
    mv kubernetes-handbook-master gitbook && \
    cd gitbook && gitbook install && \
    rm -rf /gitbook 

RUN wget --no-check-certificate https://codeload.github.com/ymcatar/gitbook-test/zip/master && \
    unzip master && \
    rm -rf master && \
    mv gitbook-test-master gitbook && \
    cd gitbook && gitbook install && \
    rm -rf /gitbook

WORKDIR /gitbook
VOLUME /gitbook /html
EXPOSE 4000 35729

CMD /usr/local/bin/gitbook install && /usr/local/bin/gitbook serve
