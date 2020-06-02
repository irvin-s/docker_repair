FROM debian:stretch
LABEL maintainer="MassGrid Developers <dev@massgrid.com>"
LABEL description="Dockerised MassGrid, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
