docker-compose run -d --service-ports notebook
Sleep 1
if ((docker-machine ssh default docker ps) -join "\n" -match "jupyter_notebook[\w\d_]+") {
  $cid = $Matches[0]
  if ((docker-machine ssh default docker exec $cid jupyter notebook list) -join "\n" -match "\?token=(\w+)") {
    $ip = docker-machine ip
    $token = $Matches[1]
    start ("http://{0}:8888/?token={1}" -f $ip, $token)
  }else {
    echo "Notebook Open Failed"
  }
}else {
  echo "Container Boot Failed"
}
