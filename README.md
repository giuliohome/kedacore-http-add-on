# kedacore http-add-on example
pointing the container image to my [web app](https://github.com/giuliohome/web-golang) in go

# setup cluster
via terraform as per my project's folder [k8s](https://github.com/giuliohome/gcp-k8s-sql-tf/tree/main/k8s)
```
terraform apply
```

# setup keda
Notice that, for example in case of Google shell, you'll need to connect to the cluster before running the following commands.
That would be something like
```
gcloud container clusters get-credentials my-cloud-giulio-dev-v1-mytf --region us-central1 --project my-cloud-giulio
```
Then you can proceed with Helm as follows.
```
kubectl create namespace keda
helm install keda kedacore/keda --namespace keda
```
# setup http add-on
```
helm install http-add-on kedacore/keda-add-ons-http --namespace keda
```
Change the [host](https://github.com/giuliohome/kedacore-http-add-on/blob/main/xkcd/values.yaml#L2) as appropriate in the value of your local CRD called `HTTPScaledObject` and finally, from this repository's root
```
kubectl create -n keda -f v0.2.0/httpscaledobject.yaml
```

# quick daemon
```
kubectl port-forward svc/keda-add-ons-http-interceptor-proxy -n keda 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
```

# Test it
Scaling to zero before connection
```
giuliohome@cloudshell:~ (my-cloud-giulio)$ kubectl get deploy xkcd -n keda
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
xkcd   0/0     0            0           29m
```
Start a http connection
```bash
curl -H "Host: myhost.com" http://127.0.0.1:8080/view/a1
```
output
```html
<h1>a1</h1>

<p>[<a href="/edit/a1">edit</a>]</p>

<div>web app in golang tested OK! ;-)</div>
```
