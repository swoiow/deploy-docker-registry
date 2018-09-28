#!/usr/bin/env bash

# https://docs.docker.com/registry/

docker stop registry
docker rm registry
if [ ! -f ./certs/domain.key ] || [ ! -f ./certs/domain.crt ] ; then
    docker run -v $PWD/certs:/work -it frapsoft/openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /work/domain.key -out /work/domain.crt -subj "/C=CN/ST=GD/L=GZ/O=Global Security/OU=Docker Dev/CN=docker-registry.io/"
fi
docker run -d \
  -p 443:5000 \
  --restart=always \
  --name registry \
  -v `pwd`/registry:/var/lib/registry \
  -v `pwd`/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2
