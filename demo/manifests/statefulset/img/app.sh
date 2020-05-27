#!/bin/sh

#[[ `hostname` =~ -([0-9]+)$ ]] || exit 1
#ordinal=${BASH_REMATCH[1]}

ordinal=$(echo $HOSTNAME | awk -F '-' '{print $NF}')
masterip=$(nslookup -query=a sts-example-0.app.default.svc.cluster.local.| awk -F': ' 'NR==5 { print $2 } ')

if [[ $ordinal -eq 0 ]]; then
    echo "I am the master, doing nothing..." > /data/index.html
else
    echo "I am slave $HOSTNAME, syncing from master sts-example-0 with IP $masterip" > /data/index.html
fi


busybox httpd -f -h /data
