#!/usr/bin/env zsh
#shellcheck shell=bash
"$KINDEST_ARGO_CD_SCRIPTS_ROOT/argocd/wait-for-password.sh"
"$KINDEST_ARGO_CD_SCRIPTS_ROOT/argocd/forward-port.sh" &
argocd version
