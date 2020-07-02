#!/bin/bash
#
# https://github.com/cdennig/k8s-custom-metrics.git
#
counts=$1

curl -X POST -H "Content-Type: application/json" 'http://10.110.113.114:4000/api/count' \
-d '{"count": '"$counts"'}'