If you are running minikube, please enable the NGINX Ingress controller add-on, run the following command:

```
# enable ingress addon
minikube addons enable ingress

# make sure the pod with name nginx-ingress-controller-xxx is Running
kubectl get pods -n kube-system
```

If you are not running minikube, please deploy nginx ingress controller with the manifest:
```
kubectl apply -f controller-deploy.yaml
```


Make sure you also have the underlying deployment/service deployed before applying the ingress rules.
