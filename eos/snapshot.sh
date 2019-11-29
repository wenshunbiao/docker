#!/bin/bash
#set -x

doing=`ps -ef |grep "wasabisys.com" | awk 'END {print NR}'`
if [ $doing -gt 1 ];then
  echo "###################### exit $doing ###################"
  exit $doing
fi

wget https://eosnode.tools/snapshots -O snapshots -o /dev/null
target=`cat snapshots | awk -F: '/td/' |sed -n '1p' | sed 's/<td>//g' |sed 's#</td>##g' | sed 's/\s//g'`
echo "target=$target"
cd /root/
list=`ls -t snap_*.tar.gz`
echo "list=$list"
exist=0
for tar in $list
do 
  echo "tar=$tar"
  if [ "$target" == "$tar" ];then
    exist=1
    break
  fi
done

echo "exist=$exist"
if [ "$exist" == "0" ];then
  echo "wget https://s3.wasabisys.com/eosnode.tools/snapshots/$target"
  wget https://s3.wasabisys.com/eosnode.tools/snapshots/$target -O $target -o /dev/null
  echo "=========== wget $target finish =============" 

  cp $target /root/.local/share/eosio/nodeos/data/snapshot.tar.gz
fi

#for tar in $list
#do
#  if [ "$target" == "$tar" ];then
#    continue
#  else
#    rm -rf $tar
#  fi
#done

echo "snapshot End"

