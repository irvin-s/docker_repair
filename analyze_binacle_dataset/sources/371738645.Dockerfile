# Shodan cli Docker Container

FROM ubuntu:14.04

MAINTAINER Jason Soto "www.jasonsoto.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update ; apt-get -y install python-pip \
    python-dev

RUN pip install shodan

ENTRYPOINT ["/bin/bash"]
