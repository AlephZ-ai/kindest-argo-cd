#!/usr/bin/env zsh
#shellcheck shell=bash
# "$KINDEST_ARGO_CD_SCRIPTS_ROOT/argocd/self-manage.sh"
# Setup Zsh profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
"$KINDEST_ARGO_CD_SCRIPTS_ROOT/devspace/setup/setup-zshrc.sh"
