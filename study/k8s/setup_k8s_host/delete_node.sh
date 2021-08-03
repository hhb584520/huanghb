
# If the cluster is created by kops

$ kubectl drain <node-name>
# now all the pods will be evicted

# ignore daemeondet:
$ kubectl drain <node-name> --ignore-daemonsets --delete-local-data

$ kops edit ig  nodes-3  --state=s3://bucketname

# set max and min value of instance group to 0

$ kubectl delete node
$ kops update cluster --state=s3://bucketname  --yes

Rolling update if required:

$ kops rolling-update cluster  --state=s3://bucketname  --yes

validate cluster:

$ kops validate cluster --state=s3://bucketname

Now the instance will be terminated.
