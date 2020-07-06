#!/bin/bash
#
echo '----'
echo "user=elastic"
PASSWORD=$(kubectl get secret quickstart-es-elastic-user -n elastic-system -o go-template='{{.data.elastic | base64decode}}')
echo "password=$PASSWORD"
echo '----'
