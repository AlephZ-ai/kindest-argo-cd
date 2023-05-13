# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring
$script = $PSCommandPath | Resolve-Path -Relative
Write-Host "${script}: Starting."
try {
    & "$($PSScriptRoot | Resolve-Path -Parent -Abosulte)/devspace/setup/set-env-vars.ps1"
    & "$env:SCRIPTS_ROOT/openssl/generate-https-cert.ps1" -certpurpose (ConvertTo-SecureString -String -AsPlainText -Force "$KINDEST_ARGO_CD_ARGO_NAME-server-tls") -password "$KINDEST_ARGO_CD_ARGO_NAME-server-tls-password"
    & "$env:SCRIPTS_ROOT/openssl/generate-https-cert.ps1" -certpurpose (ConvertTo-SecureString -String -AsPlainText -Force "$KINDEST_ARGO_CD_ARGO_NAME-repo-server-tls") -password "$KINDEST_ARGO_CD_ARGO_NAME-repo-server-tls-password"
    & "$env:SCRIPTS_ROOT/generate-https-cert.ps1" -certpurpose (ConvertTo-SecureString -String -AsPlainText -Force "$KINDEST_ARGO_CD_ARGO_NAME-dex-server-tls") -password "$KINDEST_ARGO_CD_ARGO_NAME-dex-server-tls-password"
} catch [System.Exception] {
    Write-Error "${script}: Error: $_"
    exit 1
} finally {
    Write-Host "${script}: Finished."
}
