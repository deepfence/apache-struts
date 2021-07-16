#!/bin/sh

if [ $# -lt 4 ]; then
  echo -e "\n  Usage: ${0##*/} [required] [optional]\n"
  echo -e "    Required:"
  echo -e "      --registry         example: registry.deepfence.net"
  echo -e "      --type             example: app | exploit\n"
  echo -e "    Optional:"
  echo -e "      --push             Push image to repository"
  echo -e "      --repo             example: apache-struts-app (default)"
  echo -e "      --tag              example: latest (default)\n"
  exit 1
fi

while [ $# -gt 1 ]; do
  case "$1" in
    "--push" )
        push=true
        shift; shift
        ;;
    "--registry" )
        registry=$2
        shift; shift
        ;;
    "--repo" )
        repo=$2
        shift; shift
        ;;
    "--tag" )
        tag=$2
        shift; shift
        ;;
    "--type" )
        type=$2
        shift; shift
        ;;
    * )
        echo -e "\n  Invalid argument: $1\n"
        exit 1
        ;;
  esac
done

if [ -z "${repo}" ]; then
  repo=apache-struts-app
fi

if [ -z "${tag}" ]; then
  tag=latest
fi

if [ "${type}" != "app" ] && [ "${type}" != "exploit" ]; then
  echo -e "\n  Invalid paramater: ${type}\n"
  exit 1
fi

docker build -f ./apache-struts/${type}/Dockerfile -t ${registry}/${repo}:${tag} ./apache-struts/${type}/

if [ "${push}" == "true" ]; then
  docker push ${name}/${repo}:${tag}
fi

exit 0
