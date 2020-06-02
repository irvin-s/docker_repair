FROM ubuntu:14.04

MAINTAINER Kai Mallea <kmallea@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update &&\
    apt-get install -y curl lib32gcc1

# Download and extract SteamCMD
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

WORKDIR /opt/steamcmd

# This container will be executable
ENTRYPOINT ["./steamcmd.sh"]