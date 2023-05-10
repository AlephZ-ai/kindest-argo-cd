#!/usr/bin/env bash
# TODO: Make sure this script is idempotent since it will be run multiple times
# https://argo-cd.readthedocs.io/en/stable/getting_started
namespace="argocd"
kubectl create namespace $namespace
kubectl apply -n $namespace -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# https://argo-cd.readthedocs.io/en/stable/operator-manual/tls/
./src/scripts/create-kubernetes-devcert.sh $namespace $namespace-server-tls
./src/scripts/create-kubernetes-devcert.sh $namespace $namespace-repo-server-tls
./src/scripts/create-kubernetes-devcert.sh $namespace $namespace-dex-server-tls
# https://www.pcbaecker.com/posts/setup-argocd/
# https://medium.com/devopsturkiye/self-managed-argo-cd-app-of-everything-a226eb100cf0
# https://argo-cd.readthedocs.io/en/stable/getting_started/
# https://howchoo.com/kubernetes/read-kubernetes-secrets
kubectl config set-context --current --namespace=$namespace
helm upgrade --wait --install $namespace ./src/$namespace/ --create-namespace
echo "Waiting for argo. CTRL-C to exit."
while ! (argocd cert add-tls $namespace.local --from ./devcerts/root/cert.crt 2>&1); do sleep 1; done
