FROM debian:stretch-slim
MAINTAINER Vincent Gu <v@vgu.io>

ENV OMNICORE_VER 0.5.0
ENV OMNICORE_ARCH x86_64

ENV RPC_USER user
ENV RPC_PASSWORD password
ENV RPC_ALLOWIP "::/0"
ENV LOG_OUTPUT /dev/stdout

LABEL omnicore_version="${OMNICORE_VER}" architecture="x86_64"

# define default directory
ENV APP_DIR /app
WORKDIR $APP_DIR

ENV APP_NAME omnicore
ENV APP_USER omnicore
ENV APP_GROUP omnicore
ENV DATA_DIR /data/${APP_NAME}

ENV GOSU_VERSION 1.10
ENV GOSU_ARCH amd64

ENV DEP curl bash
RUN set -ex \
&& apt-get update \
&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg curl \
&& rm -rf /var/lib/apt/lists/* \
&& groupadd omnicore \
&& useradd -r -m -g ${APP_GROUP} ${APP_USER} \
&& curl -sSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCH}" > /usr/local/bin/gosu \
&& chmod +x /usr/local/bin/gosu \
&& curl -sSL "https://github.com/OmniLayer/omnicore/releases/download/v${OMNICORE_VER}/omnicore-${OMNICORE_VER}-${OMNICORE_ARCH}-linux-gnu.tar.gz" | tar xz \
&& mv omnicore-${OMNICORE_VER} ${APP_NAME} \
&& chown -R ${APP_USER}:${APP_GROUP} ${APP_NAME} \
&& mkdir -p ${DATA_DIR} \
&& chown -R ${APP_USER}:${APP_GROUP} ${DATA_DIR} \
&& ln -sfn ${APP_NAME} /home/${APP_USER}/.bitcoin \
&& chown -R ${APP_USER}:${APP_GROUP} /home/${APP_USER}/.bitcoin

RUN apt-get install -qqy supervisor \
&&  mkdir /supervisor

COPY supervisord.conf /supervisor/supervisord.conf

COPY conf/conf.d /etc/nginx/conf.d

VOLUME /data

EXPOSE 8332

ENTRYPOINT [""]
#CMD ["/app/omnicore/bin/omnicored"]
CMD /usr/bin/supervisord -u root  -c /supervisor/supervisord.conf -n
