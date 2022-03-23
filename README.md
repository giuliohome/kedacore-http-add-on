# kedacore http-add-on example
pointing the container image to my [web app](https://github.com/giuliohome/web-golang) in go

# setup cluster
via terraform as per my project's folder [k8s](https://github.com/giuliohome/gcp-k8s-sql-tf/tree/main/k8s)
```
terraform apply
```

# setup keda
```
helm install http-add-on kedacore/keda-add-ons-http --namespace keda
```
# setup http add-on
```
helm install http-add-on kedacore/keda-add-ons-http --namespace keda
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