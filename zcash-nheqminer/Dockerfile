FROM        	debian:jessie

RUN apt-get update && apt-get install -y \ 
		cmake build-essential libboost-all-dev \
		git curl supervisor

RUN cd /root \
	&& git clone -b Linux https://github.com/nicehash/nheqminer.git 

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh 
ENTRYPOINT ["/entrypoint.sh"]
