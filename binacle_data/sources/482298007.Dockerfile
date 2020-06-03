FROM resin/rpi-raspbian:jessie-20160525
MAINTAINER NetlfixOSS <oss@netflix.com>

COPY mesos-install.tar.gz /mesos-install-tar.gz
COPY run-mesos.sh /run-mesos.sh

RUN tar -zxvf mesos-install-tar.gz && \
  apt-get update && \
  apt-get install libsvn-dev libcurl4-nss-dev && \
  chmod +x /run-mesos.sh

EXPOSE 5051
WORKDIR /
ENTRYPOINT /run-mesos.sh
