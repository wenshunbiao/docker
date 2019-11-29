#FROM golang:1.10-alpine 
FROM debian:jessie-slim 

RUN apt-get update \
    && apt-get install -qqy wget curl net-tools nginx supervisor zip \ 
    && cd / \
    && wget https://sia.tech/releases/Sia-v1.4.0-linux-amd64.zip \ 
    && unzip Sia-v1.4.0-linux-amd64.zip \ 
    && mv Sia-v1.4.0-linux-amd64 Sia \
    && mkdir /supervisor \
    && rm -rf /etc/nginx/sites-enabled/default \
    && ln -s /Sia/siad /usr/bin/siad \
    && ln -s /Sia/siac /usr/bin/siac

WORKDIR /Sia

#RUN export GOPATH=/go \
#    && go get -tags netgo -installsuffix netgo -u gitlab.com/NebulousLabs/Sia/-/archive/v1.4.0/Sia-v1.4.0.tar.gz \
#    && make dependencies \
#    && make release \
#    && make cover \
#    && mkdir /supervisor \
#    && rm -rf /etc/nginx/sites-enabled/default
    
COPY supervisord.conf /supervisor/supervisord.conf

COPY conf/ /etc/nginx/conf.d/

CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n

#CMD ""
