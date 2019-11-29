FROM node:8-alpine

ENV LANG=en_US.utf8 \
    TERM=xterm-256color

#RUN apt-get update -y && apt-get upgrade -qy && \
RUN npm install gtop -g

ENTRYPOINT ["gtop"]
