FROM ubuntu:bionic
LABEL description="Docker Decred image"
LABEL version="1.4.0"
LABEL maintainer "jpbriquet"

# Build command
# docker build -t jpbriquet/decred:v1.4.0 .

# Decred general info
ENV DECRED_VERSION v1.4.0
ENV DECRED_USER decred
ENV DECRED_GROUP decred
ENV DECRED_INSTALL /usr/local/decred
ENV DECRED_HOME /home/decred
# Decred working directories
ENV DCRD_HOME $DECRED_HOME/.dcrd
ENV DCRCTL_HOME $DECRED_HOME/.dcrctl
ENV DCRWALLET_HOME $DECRED_HOME/.dcrwallet

# Install Decred distribution
RUN \
    set -x \
    # add our user and group first to make sure their IDs get assigned consistently
    && groupadd -r $DECRED_GROUP && useradd -r -m -g $DECRED_GROUP $DECRED_USER \
    # get packages
    && BUILD_DEPS="curl gpg " \
    && apt-get update \
    && apt-get -y install supervisor $BUILD_DEPS \
    && mkdir /supervisor \
    # Register Decred Team PGP key
    && gpg --keyserver keyserver.ubuntu.com --recv-keys 0x6D897EDF518A031D \
    # Get Binaries
    && BASE_URL="https://github.com/decred/decred-binaries/releases/download" \
    && DECRED_ARCHIVE="decred-linux-amd64-$DECRED_VERSION.tar.gz" \
    && MANIFEST_SIGN="manifest-$DECRED_VERSION.txt.asc" \
    && MANIFEST="manifest-$DECRED_VERSION.txt" \
    && cd /tmp \
    && curl -LO $BASE_URL/$DECRED_VERSION/$DECRED_ARCHIVE \
    && curl -LO $BASE_URL/$DECRED_VERSION/$MANIFEST \
    && curl -LO $BASE_URL/$DECRED_VERSION/$MANIFEST_SIGN \
    # Verify authenticity - Check GPG sign + Package Hash
    && gpg --verify /tmp/$MANIFEST_SIGN \
    && grep "$DECRED_ARCHIVE" /tmp/$MANIFEST | sha256sum -c - \
    # Install
    && mkdir -p $DECRED_INSTALL \
    && cd $DECRED_INSTALL \
    && tar xzf /tmp/$DECRED_ARCHIVE \
    && mv decred-linux-amd64-$DECRED_VERSION bin \
    # Set correct rights on executables
    && chown -R root.root bin \
    && chmod -R 755 bin \
    # Cleanup
    && apt-get -y remove $BUILD_DEPS \
    && apt-get -y autoremove --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY supervisord.conf /supervisor/supervisord.conf

ENV PATH $PATH:$DECRED_INSTALL/bin

USER $DECRED_USER

# Working directories
RUN mkdir $DCRD_HOME $DCRCTL_HOME $DCRWALLET_HOME \
    && chmod -R 700 $DECRED_HOME
WORKDIR $DECRED_HOME

ENTRYPOINT []

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n
