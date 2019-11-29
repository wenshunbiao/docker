FROM alpine:3.3

RUN apk --no-cache add openssh git && rm -rf /var/cache/apk/*
#RUN adduser git -h /git -s /usr/bin/git-shell -D -H && passwd -u git

EXPOSE 22

CMD /usr/sbin/sshd -D
