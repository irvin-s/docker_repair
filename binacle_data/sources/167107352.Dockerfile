#
# Usage:
#   docker build -t mg:gui - < Dockerfile
#   xhost +si:localuser:$USER
#   docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0:ro -v ~/src/memgraphinator:/root/memgraphinator -w /root mg:gui bash
# or
#   docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0:ro -v $PWD:/app mg:gui /app/memgraphinator.py
#
# Based on macheins/ubuntu-gnome, which is basically
#
#  FROM ubuntu:14.04
#  ENV DEBIAN_FRONTEND noninteractive
#  ENV HOME /root
#  RUN apt-get update \
#   && apt-get install -y --no-install-recommends \
#          wget software-properties-common
#
# (the above being macheins/ubuntu) and then the gnome bits are
#
#  RUN apt-get install -y --no-install-recommends \
#          gnome-themes-standard gtk2-engines-pixbuf libcanberra-gtk-module
#
# and then the clean step
#
#  RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#

FROM ubuntu:14.04
MAINTAINER Marius Gedminas <marius@gedmin.as>

# see https://github.com/tianon/docker-brew-ubuntu-core/issues/14
ENV HOME /root

# suppress GTK warnings about accessibility because there's no dbus
# (WARNING **: Couldn't connect to accessibility bus: Failed to connect to socket /tmp/dbus-dw0fOAy4vj: Connection refused)
ENV NO_AT_BRIDGE 1

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        gnome-themes-standard gnome-icon-theme-full gnome-icon-theme-symbolic \
        libcanberra-gtk3-module \
        python-gobject python-gi-cairo gir1.2-gtk-3.0

# NB: an error like
#   TypeError: Couldn't find conversion for foreign struct 'cairo.Context'
# means you need to apt-get install python-gi-cairo

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
