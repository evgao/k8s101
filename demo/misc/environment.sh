#!/bin/bash
###########################
#
#  Athor: vteteam
#  Version: 0.1
############################
##
echo "Actualizando minikube ......"
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
minikube version
echo "Iniciando minikube ...."
minikube start
echo "Instalando octant ......"
wget https://github.com/vmware-tanzu/octant/releases/download/v0.12.1/octant_0.12.1_Linux-64bit.deb
dpkg -i octant_0.12.1_Linux-64bit.deb
echo "Arrancamos Octant en segundo plano ....."
OCTANT_DISABLE_OPEN_BROWSER=true  OCTANT_LISTENER_ADDR=0.0.0.0:8900 nohup octant &
