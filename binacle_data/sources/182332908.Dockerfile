#
# TODO -- don't use bd4c/baseimage
# (using for now so I don't have to think)
#
FROM       debian:stable
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

#
# This is meant to be used as a data-only container:
# https://docs.docker.com/userguide/dockervolumes/
#
# Unfortunately, in the current version of docker (2014 Nov), you cannot pickle
# a data container's volumes with it -- they live on the host machine in a kind
# of parallel shadow universe. Help is on the way, so we have chosen the
# following workaround.
#
# This container has a directory called /boxer/archive and a directory called /data.
#
# * Run with no args is the same as '--copyonce'
# * `--force-unpack` --
# * `--create`       -- if the '.unpacked' tombstone
# * `--archive`      --

RUN \
  apt-get update                                   && \
  apt-get install -y --no-install-recommends rsync nano && \
  rm -rf /var/lib/apt/lists/*

COPY img/volume_boxer/boxer/   /boxer/

RUN  \
  mkdir /boxer/archive                             && \
  ls -l /boxer

ENTRYPOINT ["/boxer/boxer.sh"]
