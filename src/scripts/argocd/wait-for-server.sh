#!/usr/bin/env zsh
#shellcheck shell=bash
"$KINDEST_ARGO_CD_SCRIPTS_ROOT/k8s/wait-for-service.sh" "$KINDEST_ARGO_CD_ARGO_NAME-server"
