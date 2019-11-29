#!/bin/bash

PROXY_PORT=1080

if [ "${ROOT_PASS}" == "**None**" ]; then
    unset ROOT_PASS
fi

if [ "${PUBLIC_HOST_ADDR}" == "**None**" ]; then
    unset PUBLIC_HOST_ADDR
fi

if [ "${PUBLIC_HOST_PORT}" == "**None**" ]; then
    unset PUBLIC_HOST_PORT
fi

if [ "${PROXY_PORT}" == "**None**" ]; then
    unset PROXY_PORT
fi

if [ "${DESTINATION_PORT}" == "**None**" ]; then
    unset DESTINATION_PORT
fi

SetRootPass()
{
    if [ -f /.root_pw_set ]; then
	    echo "Root password already set!"
    else
        PASS=${ROOT_PASS:-$(pwgen -s 12 1)}
        _word=$( [ ${ROOT_PASS} ] && echo "preset" || echo "random" )
        echo "=> Setting a ${_word} password to the root user"
        echo "root:$PASS" | chpasswd

        echo "=> Done!"
        touch /.root_pw_set

        echo "========================================================================"
        echo "You can now connect to this container via SSH using:"
        echo ""
        echo "    ssh -p <port> root@<host>"
        echo "and enter the root password '$PASS' when prompted"
        echo ""
        echo "Please remember to change the above password as soon as possible!"
        echo "========================================================================"
    fi
}

if [[ -n "${PUBLIC_HOST_ADDR}" && -n "${PUBLIC_HOST_PORT}" ]]; then
    echo "=> Running in NATed host mode"
    if [ -z "${PROXY_PORT}" ]; then
        echo "PROXY_PORT needs to be specified!"
    fi
    if [ -z "${ROOT_PASS}" ]; then
        echo "ROOT_PASS needs to be specified!"
    fi

    echo "=> Connecting to Remote SSH server ${PUBLIC_HOST_ADDR}:${PUBLIC_HOST_PORT}"

    echo "=> Set root pass"
    if [ ! -f /.root_pw_set ]; then
            SetRootPass
    fi
    /usr/sbin/sshd

    DESTINATION_PORT=22
    echo "=> Setting up the reverse ssh tunnel"
    echo "sshpass -p ${ROOT_PASS} ssh -NR ${PROXY_PORT}:localhost:${DESTINATION_PORT} root@${PUBLIC_HOST_ADDR} -p ${PUBLIC_HOST_PORT}"
    sshpass -p ${ROOT_PASS} ssh -NR ${PROXY_PORT}:localhost:${DESTINATION_PORT} root@${PUBLIC_HOST_ADDR} -p ${PUBLIC_HOST_PORT} &

    while [ 1 ]
    do
        sleep 10
        nc -w 60 -z ${PUBLIC_HOST_ADDR} 51080 > /dev/null 2>&1
        if [ $? -eq 1 ]
        then 
            exit
        fi
    done

else
    echo "=> Running in public host mode"
    if [ ! -f /.root_pw_set ]; then
	    SetRootPass
    fi
    /usr/sbin/sshd -D
fi
