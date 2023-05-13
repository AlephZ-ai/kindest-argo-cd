$script = $PSCommandPath | Resolve-Path -Relative
Write-Host "${script}: Starting."
try {
    & "$($PSScriptRoot | Resolve-Path -Parent -Abosulte)/devspace/setup/set-env-vars.ps1"
    for($i=1; $i -le 3; $i++) {
        $containerid = docker ps -q -f name=kindest-argo-cd-devspace
        if ($containerid) {
            docker rm -f $containerid
        }
        $volumes = docker volume ls -q -f name=kindest-argo-cd_devcontainer
        if ($volumes) {
            $volumes | ForEach-Object { docker volume rm -f $_ }
        }

        docker container prune -f
        docker image prune -a -f
        docker network prune -f
        docker volume prune -f
    }
} catch [System.Exception] {
    Write-Error "${script}: Error: $_"
    exit 1
} finally {
   Write-Host "${script}: Finished."
}
