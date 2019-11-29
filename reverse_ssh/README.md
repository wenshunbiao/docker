# Reverse SSH tunnel

> Extension of tifayuki/reverse-ssh-tunnel container, all thanks go to him.

## Usage (using `docker run`)

> Go to `Usage using docker compose` to run the necessary containers easier

At the final state you should have this container running 2 times, one on each machine (public server,behind firewall server).

### On public server, run:
```
[public]$ docker run -d \
    -e ROOT_PASS=<your_password> \
    -p <your_sshd_port>:22 \
    -p <forwarding_behind_firewall_port>:1080 \
    ivories/reverse_ssh:1.0
```
Parameters:
```
  <your_password> is the password used for NATed host to connect the public host
  <your_sshd port> is the port for NATed host to connect to
  <forwarding_behind_firewall_port> is the port allows others to direct access behind firewall server
```

### On behind firewall server, aka destination

[firewall server]$ docker run -d \
    -e PUBLIC_HOST_ADDR=<public_host_address> \
    -e PUBLIC_HOST_PORT=<public_host_port> \
    -e ROOT_PASS=<your_password> \
    ivories/reverse_ssh:1.0
```
Parameters:
```
  <public_host_address> is the ip address or domain of your public host
  <public_host_port> is the same as <your sshd port> set on the public host
  <your_passorwd> is the same as <your passorwd> set on the public host
```

### On client, connect to behind firewall server
```
[client]$ ssh -p <forwarding_behind_firewall_port> root@<public_host_address>
```

Example
-------

On public server(`111.112.113.114`):
```
  docker run -d -e ROOT_PASS=mypass -p 53333:22 -p 51080:1080 ivories/reverse_ssh:1.0
```
On firewall server:
```
  docker run -d -e PUBLIC_HOST_ADDR=111.112.113.114 -e PUBLIC_HOST_PORT=53333 -e ROOT_PASS=mypass ivories/reverse_ssh:1.0
```
On your laptop:
```
  ssh -p 51080 user@111.112.113.114
```
