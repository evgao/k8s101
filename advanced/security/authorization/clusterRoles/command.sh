kubectl create clusterrole cluster-reader --verb=get,list,watch --resource=pod -o yaml --dry-run > clusterReader.yaml
