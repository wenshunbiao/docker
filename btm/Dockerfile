FROM golang:1.11.5

ARG btm_branch=v1.0.9

RUN git clone https://github.com/Bytom/bytom.git $GOPATH/src/github.com/bytom \
    && cd $GOPATH/src/github.com/bytom \
    && git checkout $btm_branch \
    && make bytomd \
    && make bytomcli 
    

#FROM debian:jessie-slim
 
#RUN apt-get update \ 
#    && apt-get install -yqq nginx \
#    && sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf \
#    && rm -rf /etc/nginx/sites-enabled/default
#    
###COPY --from=0 /go/src/github.com/bytom/cmd/bytomd   /btm/
###COPY --from=0 /go/src/github.com/bytom/cmd/bytomcli /btm/
###COPY --from=0 /go/src/github.com/bytom/cmd/miner    /btm/
#
##COPY --from=0 /go/src/github.com/bytom/cmd         /btm
#RUN cp -r  /go/src/github.com/bytom/cmd /btm
#

FROM golang:1.10-alpine

COPY --from=0 /go         /go

RUN cd /go/src/github.com/bytom/ \
    && go install ./cmd/bytomd \ 
    && go install ./cmd/bytomcli \
    && rm -rf /go/src 

RUN apk update \
    && apk add nginx supervisor \
    && rm -rf /etc/nginx/sites-enabled/default \
    && mkdir -p  /supervisor \
    && sed -i "s#pcre_jit on;#pid /run/nginx.pid;#g" /etc/nginx/nginx.conf

#COPY start.sh /

#RUN chmod +x /start.sh

#ENTRYPOINT ["/start.sh"]

#CMD ["mainnet"]


COPY supervisord.conf /supervisor/supervisord.conf

COPY conf/ /etc/nginx/

CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n

#CMD [""]
