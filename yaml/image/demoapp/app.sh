#!/bin/sh
#

IPADDR=$(ifconfig eth0 | grep 'inet addr' | awk '{print $2}')

mkdir -p /var/www/html

echo "hostname:$HOSTNAME - $IPADDR - version:3" > /var/www/html/index.html

busybox httpd -f -h /var/www/html/
