FROM debian

ARG user=lbry

ENV LBRY_USER=${user}

# Download the lbry.io
RUN set -x \
  && apt-get update \
  && apt-get install -y curl ca-certificates unzip sudo \
  && curl -L https://github.com/lbryio/lbry/releases/download/v0.18.2/lbrynet-daemon-v0.18.2-linux.zip -o lbrynet.linux.zip \
  && unzip lbrynet.linux.zip -d /usr/local/bin \
  && rm lbrynet.linux.zip \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 5279

VOLUME ["/home/${user}/.lbrynet", "/home/${user}/.lbryum", "/home/${user}/Downloads"]

# Create a user to run the daemon as
RUN useradd --home-dir "/home/${user}" "${user}" \
  && chown -R "${user}:${user}" "/home/${user}"

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT [ "entrypoint.sh" ]
