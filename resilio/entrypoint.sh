#!/bin/sh

mkdir -p /mnt/sync/folders
mkdir -p /mnt/sync/config

exec /usr/local/bin/rslsync --config /etc/sync.conf --nodaemon $*
