#!/usr/bin/env bash
secret=argocd-initial-admin-secret
./src/scripts/argo/wait-for-argo-password.sh
password=$(kubectl get secret $secret -o jsonpath="{.data.password}" | base64 --decode)
argocd login --insecure localhost:17443 --username admin --password "$password"
