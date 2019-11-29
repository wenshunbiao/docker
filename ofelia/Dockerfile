FROM golang:1.10.0 AS builder

WORKDIR ${GOPATH}/src/github.com/mcuadros/ofelia

ENV CGO_ENABLED 0
ENV GOOS linux

RUN mkdir -p ${GOPATH}/src/github.com/mcuadros && cd ${GOPATH}/src/github.com/mcuadros \
    && git clone https://github.com/mcuadros/ofelia.git ofelia
RUN cd ${GOPATH}/src/github.com/mcuadros/ofelia && go get -v ./... && go build -a -installsuffix cgo -ldflags '-w  -extldflags "-static"' -o /go/bin/ofelia .

FROM alpine

RUN apk add --no-cache git bash openssh-client
COPY --from=builder /go/bin/ofelia /usr/bin/ofelia

VOLUME /etc/ofelia/
ENTRYPOINT ["/usr/bin/ofelia"]

CMD ["daemon", "--config", "/etc/ofelia/config.ini"]
