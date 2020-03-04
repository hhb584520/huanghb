# k8s api
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.10/

# set api proxy
kubectl proxy --port=8080 &

# api
curl http://localhost:8080/api/v1/namespaces/kube-system/pods/weave-net-w7fwm
curl http://localhost:8080/api/v1/nodes # get node feature labels
