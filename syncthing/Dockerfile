FROM syncthing/syncthing

MAINTAINER Ivories <ivories@ivories.com>

USER root

ENTRYPOINT env HOME=/var/syncthing /bin/syncthing -home /var/syncthing/config -gui-address 0.0.0.0:8384
