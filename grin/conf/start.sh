#!/bin/bash

#grin server run

#nginx


grin-wallet listen < ~/.grin/passwd &

sleep 5

grin-wallet owner_api < ~/.grin/passwd &

sleep 86400

