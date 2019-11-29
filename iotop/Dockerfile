FROM alpine

RUN apk update && apk add iotop --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

ENTRYPOINT ["iotop"]
