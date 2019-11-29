FROM polfilm/tron-java as builder

ARG trx_branch=master

RUN git fetch --prune \
    && git fetch --tags \
    && git checkout $trx_branch 

RUN apt-get update \
    && apt-get install -qqy nginx supervisor \
    && mkdir /supervisor \
    && rm -rf /etc/nginx/sites-enabled/default \ 
    && cd /home/java-tron \
    && mkdir fullnode \ 
    && mkdir soliditynode \
    && ./gradlew build -x test \
    && cp build/libs/FullNode.jar ./fullnode/ \
    && cp build/libs/SolidityNode.jar ./soliditynode/ \
    && wget https://raw.githubusercontent.com/tronprotocol/tron-deployment/master/main_net_config.conf -O config.conf 

FROM polfilm/tron-java

RUN apt-get update \
    && apt-get install -qqy nginx supervisor net-tools \
    && mkdir /supervisor \
    && rm -rf /etc/nginx/sites-enabled/default \
    && mkdir fullnode \
    && mkdir soliditynode 

COPY --from=builder  /home/java-tron/build/libs/FullNode.jar /home/java-tron/fullnode/ 
COPY --from=builder  /home/java-tron/build/libs/SolidityNode.jar /home/java-tron/soliditynode/ 
COPY --from=builder  /home/java-tron/config.conf /home/java-tron/fullnode/
COPY --from=builder  /home/java-tron/config.conf /home/java-tron/soliditynode/

RUN sed 's/port = 50051/port = 50052/g' /home/java-tron/soliditynode/config.conf > tmp \
    && mv tmp /home/java-tron/soliditynode/config.conf

COPY supervisord.conf /supervisor/supervisord.conf

COPY conf/ /etc/nginx/conf.d/

CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n

#CMD "java -jar /home/java-tron/fullnode/FullNode.jar -c /home/java-tron/fullnode/config.conf"
