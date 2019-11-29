FROM golang:1.8.3-alpine

RUN apk add --no-cache git
RUN go get -u github.com/Masterminds/glide && \
    git clone https://github.com/HcashOrg/hcashd $GOPATH/src/github.com/HcashOrg/hcashd && \
    cd $GOPATH/src/github.com/HcashOrg/hcashd && \
    glide install && \
    go install $(glide nv)

