#! /bin/bash

EMACS_DIR=/home/core/data/emacs
EMACS_SSH_DIR=/home/core/.ssh/emacs

if [ ! -f "$EMACS_SSH_DIR/id_rsa" ]
then
        echo 'StrictHostKeyChecking no' >> /home/core/.ssh/config
        echo 'UserKnownHostsFile /dev/null' >> /home/core/.ssh/config
        sudo mkdir -p $EMACS_SSH_DIR
        sudo ssh-keygen -f $EMACS_SSH_DIR/id_rsa -N '' -t rsa
        sudo cat $EMACS_SSH_DIR/id_rsa.pub | update-ssh-keys -a core
        sudo cp -rfp $EMACS_SSH_DIR/id_rsa.pub $EMACS_SSH_DIR/authorized_keys
        sudo cp -rfp /home/core/.ssh/config $EMACS_SSH_DIR/config
fi

echo "init ..."
docker stop emacs 2>/dev/null
echo "start ..."
docker rm emacs 2>/dev/null

docker run -d --name emacs -p 127.0.0.1:5858:22 -v $EMACS_DIR/root:/root -v $EMACS_SSH_DIR:/root/.ssh -v $EMACS_DIR:/root/.emacs.d -v /home/core/data:/data -v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key ivories/emacs

sleep 3s

sudo ssh -t -i $EMACS_SSH_DIR/id_rsa root@localhost -p 5858 'e'

docker stop emacs && docker rm emacs &

