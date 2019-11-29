#!/bin/bash -e

# Enable debug if requested
if [ "${DEBUG}" = "true" ]; then
  set -x
fi

# If command is provided run that
if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

LBRY_HOME="/home/lbry"
LBRYUM="${LBRY_HOME}/.lbryum"
LBRYNET="${LBRY_HOME}/.lbrynet"
LBRY_DOWNLOADS="${LBRY_HOME}/Downloads"
LBRY_DAEMON_SETTINGS="${LBRYNET}/daemon_settings.yml"

if [ ! -e "${LBRY_DAEMON_SETTINGS}" ]; then
  echo "Initialising daemon settings"

  echo "api_host: '0.0.0.0'" > ${LBRY_DAEMON_SETTINGS}
fi

# Make sure the LBRY_USER owns the config directories
chown "${LBRY_USER}" "${LBRYUM}" "${LBRYNET}" "${LBRY_DOWNLOADS}"

# Run the daemon
exec sudo -u "${LBRY_USER}" lbrynet-daemon
