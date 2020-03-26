FROM debian:jessie
MAINTAINER Máximo Cuadros <mcuadros@gmail.com>

RUN apt-get update \
	&& apt-get install -y ca-certificates \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DOCKER_HOST unix:///var/run/docker.sock

ADD gce-docker /bin/
CMD ["gce-docker"]
