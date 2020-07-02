kubectl create role pod-reader --verb=get,list,watch --resource=pods --dry-run -oyaml > pod-reader.yaml

kubectl create rolebinding  andy-pod-reader --role=pod-reader --user=andy


kubectl describe role
kubectl describe rolebinding




kubectl config use-context andy@kubernetes
kubectl get pod
kubectl get deployment
