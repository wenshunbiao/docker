FROM alpine:edge
ENV PACKAGE "aria2 bash curl tzdata"

RUN 	apk add --no-cache $PACKAGE && \
	cp /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
	echo "Australia/Sydney" > /etc/timezone && \
	# Add a user to run as non root
	adduser -D -g '' aria2

USER root
ENV HOME /aria2

RUN mkdir -p /aria2/.cache/aria2/ 
ADD dht.dat /aria2/.cache/aria2

CMD ["/usr/bin/aria2c","--conf-path=/home/aria2/aria2.conf"]
