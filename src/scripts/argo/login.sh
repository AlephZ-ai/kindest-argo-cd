#!/usr/bin/env bash
secret=argocd-initial-admin-secret
./src/scripts/argo/wait-for-argo-password.sh
./src/scripts/argo/wait-for-argo-server.sh
./src/scripts/argo/forward-ports-continously.sh $
password=$(kubectl get secret $secret -o jsonpath="{.data.password}" | base64 --decode)
argocd login --insecure localhost:"$KINDEST_ARGO_CD_ARGO_PORT" --username admin --password "$password"
