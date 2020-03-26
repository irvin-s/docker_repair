FROM scratch
MAINTAINER schachr <schachr@github.com>

ADD raspbian.image.tar.xz /

ENV DEBIAN_FRONTEND noninteractive
