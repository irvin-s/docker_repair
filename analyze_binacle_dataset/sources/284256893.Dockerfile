FROM debian:jessie-backports

RUN apt-get update && \
  apt-get install --no-install-recommends -y dnsmasq && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*
