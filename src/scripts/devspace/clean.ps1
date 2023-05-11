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
