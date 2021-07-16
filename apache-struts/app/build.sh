#!/bin/sh

dockerfile=Dockerfile
registry=("registry.deepfence.net" "122565780891.dkr.ecr.us-west-1.amazonaws.com")
repo=apache-struts-app
tag=latest

if [ $# -gt 0 ]; then
  while [ $# -gt 0 ]; do
    case "$1" in
      "--help" )
          echo -e "\n  Usage: ${0##*/} [optional]\n"
          echo -e "    Optional:"
          echo -e "      --push             Push image to repository\n"
          exit 1
          ;;
      "--push" )
          push=true
          shift;
          ;;
      * )
          echo -e "\n  Invalid argument: $1\n"
          exit 1
          ;;
    esac
  done
fi

for name in ${registry[@]}; do
  docker build -f ${dockerfile} --tag ${name}/${repo}:${tag} .

  if [ "${push}" == "true" ]; then
    docker push ${name}/${repo}:${tag}
  fi
done

yes | docker image prune
