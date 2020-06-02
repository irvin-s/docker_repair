FROM bitnami/minideb
MAINTAINER Angus Lees <gus@bitnami.com>

RUN install_packages curl bash openssl ca-certificates telnet make

RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

RUN \
 set -e; \
 v=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
 curl -LO https://storage.googleapis.com/kubernetes-release/release/$v/bin/linux/amd64/kubectl; \
 chmod +x kubectl; \
 mv kubectl /usr/local/bin/

COPY pwnchart /pwnchart/
COPY tls.make /usr/local/bin/
