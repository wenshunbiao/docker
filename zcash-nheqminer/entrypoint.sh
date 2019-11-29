#!/bin/bash
#echo "-> Update DNS"
#echo "nameserver 223.5.5.5" > /etc/resolv.conf
#echo "nameserver 223.6.6.6" >> /etc/resolv.conf


buildok="/root/build.ok"
if [ ! -f "$buildok" ]
then
	echo "Prepare Mining Zcash"
	cd /root/nheqminer/cpu_xenoncat/Linux/asm/
	sh assemble.sh
	cd ../../../Linux_cmake/nheqminer_cpu
	cmake .
	make -j $(nproc)
	touch $buildok
fi

sleep 5
echo "Launch Mining Zcash"
cd /root/nheqminer/Linux_cmake/nheqminer_cpu; ./nheqminer_cpu \
-l $stratum -u $workeruser -p $workerpwd -t $cpulim &

echo "Launch Supervisor"
/usr/bin/supervisord

exec "$@"
