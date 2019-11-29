#!/bin/bash
function substr
{
    STRING_A=$1
    STRING_B=$2

    if [[ ${STRING_A/${STRING_B}//} == $STRING_A ]]
    then
        ## is not substring.
        #echo N
        return 0
    else
        ## is substring.
        #echo Y
        return 1
    fi
}

echo "/data 127.0.0.1(rw,sync,fsid=0,no_root_squash,no_subtree_check)" >> /etc/exports
mkdir -p /data

service rpcbind start
service nfs-common start
service glusterfs-server start

while [ 1 ]
do
    a="$SERVER_NAME"
    arr=($a)
    IFS=","
    for s in ${arr[@]}
    do
        gluster peer probe $s
    done

    mount -t glusterfs 127.0.0.1:/data /data
    service nfs-kernel-server start
    sleep 5s
done

