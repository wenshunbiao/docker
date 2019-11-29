FROM hashicorp/terraform

USER root

RUN apk --no-cache add gettext ca-certificates openssl \
    && wget https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 -O /usr/local/bin/dumb-init \
    && wget https://storage.googleapis.com/kubernetes-release/release/v1.13.4/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod a+x /usr/local/bin/kubectl /usr/local/bin/dumb-init \
    && apk --no-cache del ca-certificates openssl

RUN apk --no-cache add bash

ENTRYPOINT [""]
