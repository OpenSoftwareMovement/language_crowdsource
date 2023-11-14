#!/bin/bash

#/ Usage: contribute.sh [-hkbcra]
#/
#/ Updates Docker image and runs the container on a given localhost port
#/ 
#/ OPTIONS:
#/    -h                  |   --help         Show this message
#/    -k                  |   --kill         Kill all containers
#/    -b <tag>            |   --build        Build image
#/    -c <tag> <port>     |   --container    Run container
#/    -r <tag> <port>     |   --remove       Remove container
#/    -a <tag> <port>     |   --all          Remove current container running on the same port, rebuild image and run containers
#/
#/    <tag>               : the image tag
#/    <port>              : the tcp port the application runs on


usage() {
  grep "^#/" <"$0" | cut -c4-
  exit
}

[ $# -eq 0 ] && usage 1

option=$1
shift

tag=${1:-"latest"}
port=${2:-"3000"}

base_app="crowdsource_frontend"
image_name="${base_app}":"${tag}"
container_name="${base_app}_${tag}"

remove_tagged_container_image() {
  docker rm -f "$container_name"
}

build_tagged_image() {
  docker build -t "$image_name" .
}

run_container() {
  docker run -dp "127.0.0.1:$port":3000 --name "$container_name" "$image_name"
}

do_all() {
  remove_tagged_container_image
  build_tagged_image
  run_container
}

kill_all_containers() {
  for container_id in $(docker ps -q --filter name="crowdsource_frontend*")
  do
    docker rm -f $container_id
  done
}

case "$option" in
  -h|--help)
    usage
    exit
    ;;
  -k|--kill)
    kill_all_containers
    exit
    ;;
  -b|--build)
    build_tagged_image
    exit
    ;;
  -c|--container)
    run_container
    exit
    ;;
  -r|--remove)
    remove_tagged_container_image
    exit
    ;;
  -a|--all)
    do_all
    exit
    ;;
  esac