FROM cantino/huginn

RUN sed 's/exec \/usr\/bin/#exec/g' /scripts/init > /init
RUN chmod -R 777 /init && /init
RUN echo "/usr/bin/supervisord -c /etc/supervisor/supervisord.conf" >> /usr/bin/start
RUN chmod -R 777 /usr/bin/start

CMD "start"

#RUN apt-get update && apt-get install tsocks && rm -rf /var/lib/apt/lists/*
#RUN pip install shadowsocks
#RUN sed 's/exec \/usr\/bin/#exec/g' /scripts/init > /init
#RUN chmod -R 777 /init && /init
#RUN echo "sslocal -c /etc/shadowsocks.json &" >> /usr/bin/start
#RUN echo "export http_proxy=http://127.0.0.1:1080" >> /etc/environment
#RUN echo "export https_proxy=http://127.0.0.1:1080" >> /etc/environment
#RUN echo "export http_proxy=http://127.0.0.1:1080" >> ~/.bashrc
#RUN echo "export https_proxy=http://127.0.0.1:1080" >> ~/.bashrc
#RUN echo "/usr/bin/supervisord -c /etc/supervisor/supervisord.conf" >> /usr/bin/start
#RUN chmod -R 777 /usr/bin/start

#CMD "start"
