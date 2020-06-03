FROM debian:7.6
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN \
  echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list && \
  apt-get update -yq && apt-get install -yqq openjdk-8-jre-headless=8u40~b09-1 \
    wget=1.15-1+b1 \
    unzip=6.0-12 && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

CMD /bin/bash
