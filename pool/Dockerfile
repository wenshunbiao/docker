FROM protinam/wyvern-solo-pool

ADD algoProperties.js /node_modules/stratum-pool/lib
ADD package.json /node_modules/stratum-pool 
RUN cd /node_modules/stratum-pool  && npm install
RUN sed -i "s#name: 'Wyvern'#name: 'hcash'#g" pool.js && \
    sed -i "s#symbol: 'WYV',#symbol: 'HSR',#g" pool.js && \
    sed -i "s#address: addr#address: \"HSPgrRL6SnAkUaDArYBFFHauyAMf6CzCR4\"#g" pool.js && \
    sed -i "s#algorithm: 'nist5'#algorithm: 'x14hcash'#g" pool.js

