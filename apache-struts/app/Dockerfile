FROM maven:3-jdk-8-slim

# https://github.com/jrrdev/cve-2017-5638
MAINTAINER "Matt Kryshak <matt@deepfence.io>"

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y at netcat strace \
	&& apt-get purge --auto-remove -y \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& rm -rf /var/lib/apt/lists/*

COPY source/main /usr/src/cve-2017-5638/src/main
COPY source/pom.xml /usr/src/cve-2017-5638/

RUN set -x \
	&& mkdir -p /cve-2017-5638 \
	&& cd /usr/src/cve-2017-5638 \
	&& mvn package \
	&& cp /usr/src/cve-2017-5638/target/*jar /cve-2017-5638/cve-2017-5638-example.jar \
	&& rm -rf /usr/src/cve-2017-5638

COPY entry-point.sh /entry-point.sh
COPY visualization.sh /visualization.sh

RUN set -x \
	&& chmod +x /entry-point.sh /visualization.sh

EXPOSE 8080

ENTRYPOINT ["/entry-point.sh"]
