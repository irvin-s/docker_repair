FROM debian:stretch
LABEL maintainer="Polis Developers <dev@polispay.org>"
LABEL description="Dockerised PolisCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
