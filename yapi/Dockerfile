FROM alpine

ENV YAPI_VERSION 1.9.2

COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories

RUN apk update && apk add mongodb=3.4.4-r0 nodejs npm

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

WORKDIR /yapi-src

ADD https://github.com/YMFE/yapi/archive/refs/tags/v${YAPI_VERSION}.tar.gz /yapi-src

RUN tar -zxf v${YAPI_VERSION}.tar.gz && rm v${YAPI_VERSION}.tar.gz && mv yapi-${YAPI_VERSION} vendors

RUN cd /yapi-src/vendors && cnpm install --production && cnpm cache clean --force

RUN cd /yapi-src && tar -zcf vendors.tar.gz vendors && rm -rf vendors

WORKDIR /yapi

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "node", "/yapi/vendors/server/app.js" ]
