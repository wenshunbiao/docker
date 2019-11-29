#!/bin/sh

#
# Script options (exit script on command fail).
#
set -e

#
# Define default Variables.
#
USER="named"
GROUP="named"
COMMAND_OPTIONS_DEFAULT="-f"
NAMED_UID_DEFAULT="1000"
NAMED_GID_DEFAULT="101"
COMMAND="/usr/sbin/named -u ${USER} -c /etc/bind/named.conf ${COMMAND_OPTIONS:=${COMMAND_OPTIONS_DEFAULT}}"

NAMED_UID_ACTUAL=$(id -u ${USER})
NAMED_GID_ACTUAL=$(id -g ${GROUP})

#
# Display settings on standard out.
#
echo "named settings"
echo "=============="
echo
echo "  Username:        ${USER}"
echo "  Groupname:       ${GROUP}"
echo "  UID actual:      ${NAMED_UID_ACTUAL}"
echo "  GID actual:      ${NAMED_GID_ACTUAL}"
echo "  UID prefered:    ${NAMED_UID:=${NAMED_UID_DEFAULT}}"
echo "  GID prefered:    ${NAMED_GID:=${NAMED_GID_DEFAULT}}"
echo "  Command:         ${COMMAND}"
echo

#
# Change UID / GID of named user.
#
echo "Updating UID / GID... "
if [[ ${NAMED_GID_ACTUAL} -ne ${NAMED_GID} -o ${NAMED_UID_ACTUAL} -ne ${NAMED_UID} ]]
then
    echo "change user / group"
    deluser ${USER}
    addgroup -g ${NAMED_GID} ${GROUP}
    adduser -u ${NAMED_UID} -G ${GROUP} -h /etc/bind -g 'Linux User named' -s /sbin/nologin -D ${USER}
    echo "[DONE]"
    echo "Set owner and permissions for old uid/gid files"
    find / -user ${NAMED_UID_ACTUAL} -exec chown ${USER} {} \;
    find / -group ${NAMED_GID_ACTUAL} -exec chgrp ${GROUP} {} \;
    echo "[DONE]"
else
    echo "[NOTHING DONE]"
fi

#
# Set owner and permissions.
#
echo "Set owner and permissions... "
chown -R ${USER}:${GROUP} /var/bind /etc/bind /var/run/named /var/log/named
chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/log/named
echo "[DONE]"

#
# Start named.
#
echo "Start named... "
exec ${COMMAND}
