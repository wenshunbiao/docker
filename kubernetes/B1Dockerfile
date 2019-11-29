FROM alpine:3.3

RUN apk --update add git
RUN git clone -b v1.6.0 --depth 1 https://github.com/kubernetes/kubernetes.git

ARG GLIBC_VERSION=2.23-r3
RUN apk --no-cache add ca-certificates wget \
 && wget -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
 && apk add glibc-2.23-r3.apk --no-cache \
 && rm glibc-2.23-r3.apk \
 && rm /etc/apk/keys/sgerrand.rsa.pub \
 && apk del wget ca-certificates --no-cache

RUN apk update && apk upgrade && \

    # Make info file about this build
    mkdir -p /etc/BUILDS/ && \
    printf "Build of nimmis/alpine-golang:1.3, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/alpine-golang && \

    # add extra package for installation  
    apk add curl && \

    # download and upack golang
    curl https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar xzf - -C / && \
    mv /go /goroot && \
 
    # remove extra packages
    apk del curl && \

    # remove cached info
    rm -rf /var/cache/apk/*

RUN mv /goroot /usr/local/go
RUN ln -s /usr/local/go/bin/go /usr/bin/go

RUN apk --update add bash

#RUN cd kubernetes/src/k8s.io/kubernetes/cmd/kube-apiserver & go install 
#RUN cd kubernetes/src/k8s.io/kubernetes/cmd/kube-controller-manage & go install 
#RUN cd kubernetes/src/k8s.io/kubernetes/cmd/kube-kubectl & go install 
#RUN cd kubernetes/src/k8s.io/kubernetes/cmd/kube-proxy & go install 
#RUN cd kubernetes/src/k8s.io/kubernetes/cmd/kube-dns & go install 
#RUN cd kubernetes/src/k8s.io/kubernetes/cmd/kube-discovery & go install 
#RUN cd kubernetes/src/k8s.io/kubernetes/plugin/cmd/kube-scheduler & go install 
