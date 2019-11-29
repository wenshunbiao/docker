#!/bin/bash

if [ "$(whoami)" != "root" ];then
    echo "need root"
    exit
fi

if [ "$1" == "" ] ; then
    echo "sudo make.sh domain.com"
    exit
fi

ACME_PATH=/home/core/data/www/acme/$1

mkdir -p $ACME_PATH
cd $ACME_PATH

if [ ! -f "$ACME_PATH/account.key" ]; then
    openssl genrsa 4096 > account.key
    openssl genrsa 4096 > domain.key
    openssl req -new -sha256 -key domain.key -subj "/" -reqexts SAN -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:$1")) > domain.csr
    openssl req -new -sha256 -key domain.key -out domain.csr

echo "write nginx conf:"
echo "
server {
    server_name $1;
    root /www/$1;

    location ^~ /.well-known/acme-challenge/ {
        alias /www/acme/$1/;
    }

    include php.conf;
}
"
exit 0
fi

if [ -f "$ACME_PATH/chained.pem" ]; then

    NOW_TIME=$(date +%s)
    END_TIME=$(openssl x509 -enddate -noout -in $ACME_PATH/chained.pem)
    END_TIME=${END_TIME//notAfter=/}
    END_TIME=$(date -d "$END_TIME" +%s)
    INT_TIME=`expr $END_TIME - $NOW_TIME`

    if [ "$INT_TIME" -gt "5184000" ];then
        echo "There is not time yet to apply for a new certificate."; 
        exit 0;
    fi

fi

docker run -it --rm -v $ACME_PATH:/www ivories/acme python /acme_tiny.py --account-key /www/account.key --csr /www/domain.csr --acme-dir /www/ > $ACME_PATH/signed.crt || exit

wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > intermediate.pem
cat signed.crt intermediate.pem > chained.pem
wget -O - https://letsencrypt.org/certs/isrgrootx1.pem > root.pem
cat intermediate.pem root.pem > full_chained.pem

echo "
server {
    server_name $1;
    root /www/$1;
    listen 443;
    ssl on;
    ssl_certificate     /www/acme/$1/chained.pem;
    ssl_certificate_key /www/acme/$1/domain.key;
    include php.conf;
}
"

systemctl restart nginx

