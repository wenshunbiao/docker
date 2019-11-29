#Problem

When remove /var/lib/etcd2/member,we will set a new token for etcd2.
initital-cluster-token etcd-cluster-newValue
if not set the new value,the etcd2 will shutdown have no error.

A service depend etcd,will stop the etcd2.and will infinite loop,and you will not start etcd2 again.
Slove: copy the etcd2.service to /etc/systemd/system/etcd.service and systemctl start etcd,etcd2 is replace 
etcd,so you can open the etcd2, close the wrong service.the problem was sloved.

sudo systemctl stop etcd2
etcd2 --name infra0  --initial-advertise-peer-urls http://10.162.89.49:2380 \
  --listen-peer-urls http://10.162.89.49:2380 \
  --listen-client-urls http://10.162.89.49:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://10.162.89.49:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster infra0=http://10.162.89.49:2380,infra1=http://10.162.58.57:2380,infra2=http://10.162.56.145:2380  \
  --initial-cluster-state new

sudo systemctl stop etcd2
etcd2 --name infra2  --initial-advertise-peer-urls http://10.162.56.145:2380 \
  --listen-peer-urls http://10.162.56.145:2380 \
  --listen-client-urls http://10.162.56.145:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://10.162.56.145:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster infra0=http://10.162.89.49:2380,infra1=http://10.162.58.57:2380,infra2=http://10.162.56.145:2380  \
  --initial-cluster-state new


sudo systemctl stop etcd2
etcd2 --name infra1  --initial-advertise-peer-urls http://10.162.58.57:2380 \
  --listen-peer-urls http://10.162.58.57:2380 \
  --listen-client-urls http://10.162.58.57:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://10.162.58.57:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster infra0=http://10.162.89.49:2380,infra1=http://10.162.58.57:2380,infra2=http://10.162.56.145:2380  \
  --initial-cluster-state new


