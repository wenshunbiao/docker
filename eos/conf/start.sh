#!/bin/bash

nginx
/etc/init.d/mongodb start

exec "$@"
