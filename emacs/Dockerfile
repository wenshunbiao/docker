FROM debian:stretch

RUN sed -i 's@http://deb.debian.org@http://mirrors.163.com@g' /etc/apt/sources.list
RUN sed -i 's@http://security.debian.org@http://mirrors.163.com@g' /etc/apt/sources.list

RUN apt update && apt install -y openssh-server findutils git emacs25 wget graphviz xfonts-wqy ttf-wqy-zenhei ttf-wqy-microhei
#apt-get install xfonts-wqy ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-uming

RUN echo "export TERM=xterm" >> /root/.bashrc

COPY emacs.sh /usr/bin/e
RUN chmod -R 777 /usr/bin/e
RUN cd /root && mkdir .ssh && chmod -R 700 /root/.ssh
RUN echo "PasswordAuthentication no" > /etc/ssh/sshd_config
RUN touch /authorized_keys

#RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.09.8

RUN set -eux; \ 
		dockerArch='x86_64'; \
	if ! wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for '${dockerArch}'"; \
		exit 1; \
	fi; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	docker --version

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "root:root" | chpasswd

COPY rust /usr/bin/rust
COPY rustup /usr/bin/rustup
COPY cargo /usr/bin/cargo

RUN cp /usr/local/bin/docker /usr/bin/docker

RUN mkdir /run/sshd

CMD /usr/sbin/sshd -D
