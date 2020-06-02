# Create an up to date minimal Debian Jessi build

# Pull base image
FROM debian:jessie

# Update packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get clean -y && \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -rf /usr/share/locale/* && \
  rm -rf /var/cache/debconf/*-old && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /usr/share/doc/*
