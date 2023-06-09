#!/usr/bin/env zsh
#shellcheck shell=bash
root=root
certpurpose=$root
password=$root-password
subject="/C=US/CN=Dev-Root-CA"
mkdir -p "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose"
openssl req -x509 -nodes -new -sha256 -days 3650 -newkey rsa:2048 \
    -keyout "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.key" \
    -out "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.pem" \
    -subj $subject
openssl x509 -outform pem \
    -in "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.pem" \
    -out "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.crt"
# https://stackoverflow.com/questions/808669/convert-a-cert-pem-certificate-to-a-pfx-certificate
# https://stackoverflow.com/questions/63441247/how-to-pass-pkcs12-password-into-openssl-conversion-module
openssl pkcs12 -passout pass:$password \
    -inkey "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.key" \
    -in "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.crt" -export \
    -out "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.pfx"
git add -f "$KINDEST_ARGO_CD_PROJECT_ROOT/devcerts/$certpurpose/cert.pfx"
