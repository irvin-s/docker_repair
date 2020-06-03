# VERSION:        0.7
# DESCRIPTION:    Create firefox container with its dependencies
# AUTHOR:         Daniel Mizyrycki <daniel@dotcloud.com>
# COMMENTS:
#   This file describes how to build a Firefox container with all
#   dependencies installed. It uses native X11 unix socket and alsa
#   sound devices. Tested on Debian 7.2
# USAGE:
#   # Download Firefox Dockerfile
#   wget http://raw.github.com/dotcloud/docker/master/contrib/desktop-integration/firefox/Dockerfile
#
#   # Build firefox image
#   docker build -t firefox -rm .
#
#   # Run stateful data-on-host firefox. For ephemeral, remove -v /data/firefox:/data
#   docker run -v /data/firefox:/data -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v /dev/snd:/dev/snd -lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' \
#     -e DISPLAY=unix$DISPLAY firefox
#
#   # To run stateful dockerized data containers
#   docker run -volumes-from firefox-data -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v /dev/snd:/dev/snd -lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' \
#     -e DISPLAY=unix$DISPLAY firefox

FROM debian:wheezy
MAINTAINER Jean-Christophe Saad-Dupuy <jc.saaddupuy@fsfe.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y


# Install iceweasel dependencies
run echo "deb http://ftp.debian.org/debian/ wheezy main contrib" > /etc/apt/sources.list
run apt-get update
RUN apt-get install -y iceweasel

# Fix empty $HOME
ENV HOME /home/iceweasel
# Adds a custom non root user with home directory
RUN adduser --disabled-password --home=/home/iceweasel --gecos "" iceweasel

RUN mkdir -p /data/mozilla

ADD profile/mozilla/ /data/mozilla/
RUN ln -s /data/mozilla /home/iceweasel/.mozilla

RUN chown -R iceweasel /data/mozilla
RUN chown -R iceweasel /home/iceweasel/.mozilla/


# In the user context
USER iceweasel

WORKDIR /home/iceweasel
CMD ["iceweasel"]
