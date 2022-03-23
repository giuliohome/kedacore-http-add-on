# /bin/bash
# usage example for namespace keda
# ./waitPods.sh keda

# waiting for app deploy ready
while [[ $(kubectl get deploy xkcd -n $1 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') == "True" ]] ; do echo "waiting for pod" && sleep 1; done
echo app deply ready

