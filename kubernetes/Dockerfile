FROM alpine

ENV TERM="xterm-color" KUBE_VER="v1.5.6"
ENV KUBE_MANIFESTS_URL="https://raw.githubusercontent.com/kubernetes/kubernetes/${KUBE_VER}/cluster/images/hyperkube"

RUN apk -q --no-progress add --update build-base autoconf libtool git mercurial go rsync linux-headers ca-certificates iptables
RUN mkdir -p /build/src && export GOPATH="/build" 
RUN go get -d github.com/kubernetes/kubernetes > /dev/null 2>&1 || true 

RUN apk add bash

RUN git clone -b v1.5.6 --depth 1 https://github.com/kubernetes/kubernetes 

ENV GOPATH="/kubernetes/staging/src:/kubernetes"
 
#RUN /kubernetes/hack/build-go.sh cmd/hyperkube 

RUN apk add tar 
#RUN apk add  xz-libs xz libseccomp
#RUN apk add docker

RUN mkdir -p /kubernetes/src/k8s.io
RUN ln -s /kubernetes/ /kubernetes/src/k8s.io/kubernetes

RUN ln -s /kubernetes/vendor/github.com/ /kubernetes/src/github.com
RUN mkdir /kubernetes/bin
ENV GOBIN=/kubernetes/bin
#RUN cd /kubernetes/cmd/kube-apiserver && go install
#RUN cd /kubernetes/cmd/kube-controller-manage && go install
#RUN cd /kubernetes/cmd/kube-kubectl && go install
#RUN cd /kubernetes/cmd/kube-proxy && go install
#RUN cd /kubernetes/cmd/kube-dns && go install
#RUN cd /kubernetes/cmd/kube-discovery && go install
#RUN cd /kubernetes/plugin/cmd/kube-scheduler && go install
#RUN cd /kubernetes/cmd/hyperkube/ && go install

CMD /bin/bash

#RUN cd /kubernetes/ && make quick-release
#RUN mv ./_output/local/bin/linux/amd64/hyperkube && \
#    mkdir -p /etc/kubernetes/manifests /etc/kubernetes/manifests-multi && \
#    wget -qO- ${KUBE_MANIFESTS_URL}/master-multi.json | sed "s/gcr.io\/google_containers/nebelpfade/g;s/VERSION/${KUBE_VER}/g" > /etc/kubernetes/manifests-multi/master-multi.json && \
#    wget -qO- ${KUBE_MANIFESTS_URL}/master.json | sed "s/gcr.io\/google_containers/nebelpfade/g;s/VERSION/${KUBE_VER}/g" > /etc/kubernetes/manifests/master.json && \
  
#RUN apk -q --no-progress del --purge build-base autoconf libtool git mercurial go rsync linux-headers && cd / && rm -rf /var/cache/apk/* /tmp/* /build
