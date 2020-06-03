FROM ubuntu:12.04
MAINTAINER sabalah21@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key update && apt-get update
RUN apt-get install -y sudo software-properties-common python-software-properties

RUN add-apt-repository ppa:cartodb/redis && sudo apt-get update
RUN apt-get install -y redis-server

CMD ["/bin/bash"]
