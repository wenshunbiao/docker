FROM ubuntu:17.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    apt-get update && apt-get install -y zlib1g-dev lib32z1 lib32ncurses5 curl unzip && \
    curl -o thunder.zip https://codeload.github.com/yinheli/docker-thunder-xware/zip/master && \
    unzip thunder.zip && mv docker-thunder-xware-master/ /t && \
    mv /t/thunder /app && mv /t/start.sh /app && \
     rm -rf thunder.zip && rm -rf /t && \
    apt-get remove -y curl unzip && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /app/TDDOWNLOAD
WORKDIR /app
RUN chmod +x start.sh && chmod +x ./bin/portal
CMD ["./start.sh"]
