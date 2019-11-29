FROM  ubuntu:18.04

RUN apt-get update && apt-get install -qqy wget git libleveldb-dev sqlite3 libsqlite3-dev software-properties-common && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    add-apt-repository universe && \
    apt-get install -qqy apt-transport-https && \
    apt-get update && \
    apt-get install -qqy dotnet-sdk-2.2 && \
    git clone https://github.com/neo-project/neo-cli.git && \
    cd neo-cli && \
    dotnet restore && \
    dotnet publish -c release -r linux-x64

#RUN dotnet publish -c release -r linux-x64 -o neo

RUN apt-get install -qqy nginx  supervisor && \
    mkdir /supervisor  && \ 
    rm -rf /etc/nginx/sites-enabled/default

WORKDIR /neo/publish/

COPY supervisord.conf /supervisor/
COPY conf/conf.d /etc/nginx/conf.d

CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n

