#!/bin/sh

set -e
service atd start
/visualization.sh &
exec java "$@" -jar /cve-2017-5638/cve-2017-5638-example.jar
