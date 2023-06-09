#!/usr/bin/env zsh
#shellcheck shell=bash
secret="$1"
kubectl create secret tls "$secret" \
  --cert="devcerts/$secret/cert.crt" \
  --key="devcerts/$secret/cert.key"
