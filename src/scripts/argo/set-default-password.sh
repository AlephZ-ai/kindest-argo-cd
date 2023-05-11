#!/usr/bin/env bash
# https://argo-cd.readthedocs.io/en/stable/user-guide/private-repositories/
namespace=argocd
secret=$namespace-initial-admin-secret
./src/scripts/argo/wait-for-argo-password.sh
defaultpassword=password
currentpassword=$(kubectl get secret $secret -o jsonpath="{.data.password}" | base64 --decode)
./src/scripts/argo/login.sh
if [ "$currentpassword" == "$defaultpassword" ]; then
  echo "Password already set to $defaultpassword"
  exit 0
fi
argocd account update-password --current-password "$currentpassword" --new-password $defaultpassword
encodedpassword=$(echo $defaultpassword | base64)
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  password: $encodedpassword
kind: Secret
metadata:
  name: $secret
  namespace: $namespace
type: Opaque
EOF
./src/scripts/argo/login.sh
