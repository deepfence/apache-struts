#!/bin/sh

if [ ! -d "/deepfence" ]; then
  while true; do
    curl -Is https://deepfence-public.s3.amazonaws.com/deepfence_logo_200_55.png > /dev/null
    curl -Is https://api.github.com/repos/octocat/hello-world/commits/762941318ee16e59dabbacb1b4049eec22f0d303/status > /dev/null
    curl -Is https://api.cloudflare.com/client/v4/zones/cd7d0123e3012345da9420df9514dad0 > /dev/null
    curl -Is https://gitlab.com/api > /dev/null
    sleep 5
  done
else
  while true; do
    nc -w 2 deepfence-public.s3.amazonaws.com 443 &
    nc -w 2 api.github.com 443 &
    nc -w 2 api.cloudflare.com 443 &
    nc -w 2 gitlab.com 443 &
    sleep 5
  done
fi
