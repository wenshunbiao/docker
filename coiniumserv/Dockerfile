FROM ivories/mono

#RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates tar xz && \
 #   apk del .build-dependencies && \
 #   rm /tmp/*

RUN apk add --no-cache git \
&& git clone https://github.com/CoiniumServ/CoiniumServ.git /usr/local/bin/CoiniumServ \
&& cd /usr/local/bin/CoiniumServ; git submodule init; git submodule update \
&& ls \
&& pwd \
&& cd /usr/local/bin/CoiniumServ/build/release \
&& ls \
&& pwd \
&& sh /usr/local/bin/CoiniumServ/build/release/build.sh

RUN mv /usr/local/bin/CoiniumServ/bin/Release/config/config-example.json /usr/local/bin/CoiniumServ/bin/Release/config/config.json

EXPOSE 8081
#CMD ["mono", "/usr/local/bin/CoiniumServ/build/release/CoiniumServ.exe"]
CMD ["mono", "/usr/local/bin/CoiniumServ/bin/Release/CoiniumServ.exe"]
