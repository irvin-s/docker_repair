FROM ubuntu:12.04
MAINTAINER Jose Fuentes <jfuentes@wtelecom.es>

RUN apt-get -y update && apt-get -y install ruby
RUN apt-get install -y puppet

VOLUME containerLogs /tmp/logs

ADD ./directorymanifest.pp /tmp/manifest.pp

RUN puppet apply /tmp/manifest.pp


