FROM golang:alpine as builder

RUN apk add --no-cache git
RUN apk add --no-cache build-base
RUN apk add --no-cache libpcap-dev
RUN go get github.com/ga0/netgraph


FROM alpine

COPY --from=builder /go/bin/netgraph /usr/bin/

RUN apk add --no-cache libpcap-dev


