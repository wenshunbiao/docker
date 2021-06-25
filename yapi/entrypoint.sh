#!/bin/sh
set -e

mongod --fork --dbpath /yapi/db --logpath /yapi/db/mongodb.log

tar -zxf /yapi-src/vendors.tar.gz -C /yapi

if [ ! -f "/yapi/init.lock" ]; then
  tar -zxf /yapi-src/vendors.tar.gz -C /yapi
  cd /yapi/vendors && npm run install-server
fi

exec "$@"
