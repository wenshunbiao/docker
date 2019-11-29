docker run -it --rm --net=host --privileged=true -v /home/core/data1:/gluster ivories/gluster:1.0 /bin/bash
service glusterfs-server start 
gluster peer probe master.hadoop.com && gluster peer probe slave1.hadoop.com && gluster peer probe slave2.hadoop.com && gluster peer probe slave3.hadoop.com


gluster volume create data master.hadoop.com:/gluster/brick slave1.hadoop.com:/gluster/brick slave2.hadoop.com:/gluster/brick slave3.hadoop.com:/gluster/brick
gluster volume create data replica 4 transport tcp master.hadoop.com:/gluster/brick slave1.hadoop.com:/gluster/brick slave2.hadoop.com:/gluster/brick slave3.hadoop.com:/gluster/brick


gluster volume start data
mount -t glusterfs 127.0.0.1:/data /data
echo "/data 127.0.0.1(rw,sync,no_root_squash)" /etc/exports

gluster pool list

echo "UUID=0dd7f959-8174-44d5-b5a4-a77b394e6ad7" > /var/lib/glusterd/glusterd.info
echo "operating-version=30800" >> /var/lib/glusterd/glusterd.info
