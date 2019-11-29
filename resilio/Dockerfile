FROM alpine:3.3

ARG VCS_REF
ARG BUILD_DATE

ENV RESILIO_VERSION="2.4.4" \
    DUMB_INIT_VERSION="1.2.0" \
    GLIBC_VERSION="2.23-r3"

LABEL org.label-schema.name="resilio-sync" \
      org.label-schema.url="https://github.com/oomathias/resilio-sync" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/oomathias/resilio-sync" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.schema-version="1.0" \

      com.resilio.version=$RESILIO_VERSION \
      com.yelp.dumb-init=$DUMB_INIT_VERSION \
      com.sgerrand.alpine-pkg-glibc=$GLIBC_VERSION

# Install packages
RUN \
  # tmp
  echo " ---> Upgrading OS and installing dependencies" \
  && TMP_APK='curl tar ca-certificates' \
  && apk --update upgrade \
  && apk add $TMP_APK \

  # dumb-init
  && echo " ---> Installing dumb-init (${DUMB_INIT_VERSION})" \
  && >&2 echo "dumb-init_${DUMB_INIT_VERSION}_amd64" \
  && curl -#LOS https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
  && >&2 echo "sha256sums" \
  && curl -#LOS https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/sha256sums \
  && fgrep "dumb-init_${DUMB_INIT_VERSION}_amd64$" sha256sums | sha256sum -c - \
  && mv dumb-init_${DUMB_INIT_VERSION}_amd64 /usr/local/bin/dumb-init \
  && chmod +x /usr/local/bin/dumb-init \
  && rm sha256sums \

  # glibc
  && echo " ---> Installing glibc (${GLIBC_VERSION})" \
  && >&2 echo "glibc-${GLIBC_VERSION}.apk" \
  && curl -#LOS https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && >&2 echo "sgerrand.rsa.pub" \
  && curl -#LS -o /etc/apk/keys/sgerrand.rsa.pub https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/sgerrand.rsa.pub \
  && apk add glibc-${GLIBC_VERSION}.apk \
  && rm /etc/apk/keys/sgerrand.rsa.pub glibc-${GLIBC_VERSION}.apk \

  # resilio-sync
  && echo " ---> Installing resilio-sync (${RESILIO_VERSION})" \
  && >&2 echo "resilio-sync_glibc23_x64.tar.gz" \
  && curl -#LS https://download-cdn.resilio.com/${RESILIO_VERSION}/linux-glibc-x64/resilio-sync_glibc23_x64.tar.gz | tar xzf - -C /usr/local/bin rslsync \
  && chmod +x /usr/local/bin/rslsync \

  # cleanup tmp
  && echo " ---> Cleaning" \
  && apk del --purge $TMP_APK \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/*

COPY entrypoint.sh /
COPY sync.conf /etc/
RUN chmod +x /entrypoint.sh

EXPOSE 8888 55555

VOLUME /mnt/sync
ENTRYPOINT ["/usr/local/bin/dumb-init", "/entrypoint.sh"]
CMD ["--log", "--config", "/etc/sync.conf"]
