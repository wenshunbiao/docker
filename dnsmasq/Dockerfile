FROM alpine
RUN apk --no-cache add dnsmasq
EXPOSE 53 53/udp

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD resolv.dnsmasq.conf /etc/resolv.dnsmasq.conf

ENTRYPOINT ["dnsmasq", "-k"]
