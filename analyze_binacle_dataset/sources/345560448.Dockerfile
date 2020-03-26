FROM bitnami/base-ubuntu:14.04
MAINTAINER Bitnami <containers@bitnami.com>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y build-essential git && \
  apt-get clean && \
  rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*
