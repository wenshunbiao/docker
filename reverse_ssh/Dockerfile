FROM alpine

RUN apk update && apk upgrade && apk add --update acf-openssh pwgen sshpass bash && rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/sshd && \
    mkdir -p /root/.ssh && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    sed -i "s/#ClientAliveInterval 0/ClientAliveInterval 10/g" /etc/ssh/sshd_config && \
    sed -i "s/#ClientAliveCountMax 3/ClientAliveCountMax 1/g" /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "Host *" > /etc/ssh/ssh_config && \
    echo "ServerAliveInterval 10" > /etc/ssh/ssh_config

ADD bin/run.sh /run.sh
RUN chmod +x /*.sh
ADD bin/sshconfig /root/.ssh/config

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS **None**
ENV PUBLIC_HOST_ADDR **None**
ENV PUBLIC_HOST_PORT **None**
ENV PROXY_PORT **None**
ENV DESTINATION_PORT **None**

EXPOSE 22
EXPOSE 1080

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

CMD ["/run.sh"]
