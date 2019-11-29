FROM postgres:9.3.17-alpine

RUN apk --update add wget && \
    cd /docker-entrypoint-initdb.d/ && \
    wget --no-check-certificate https://raw.githubusercontent.com/wnameless/docker-openclinica-db/master/sql/1-create_role.sql && wget --no-check-certificate https://raw.githubusercontent.com/wnameless/docker-openclinica-db/master/sql/2-create_db.sql && \   
#    wget --no-check-certificate https://dev.openclinica.com/distros/OpenClinica_JUNO_Demo_Database.zip && \
#    unzip OpenClinica_JUNO_Demo_Database.zip  && \
#    rm -rf OpenClinica_JUNO_Demo_Database* && \
    apk del wget && rm -rf /var/cache/apk/*

