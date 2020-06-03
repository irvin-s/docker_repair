FROM ubuntu:14.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        git \
        gconf2 \
        gconf-service \
        libgtk2.0-0 \
        libnotify4 \
        libxtst6 \
        libnss3 \
        python \
        gvfs-bin \
        xdg-utils \
  && curl -L https://github.com/atom/atom/releases/download/v1.4.3/atom-amd64.deb -o atom.deb \
  && dpkg -i atom.deb \
  && apt-get purge -y --auto-remove \
        curl \
  && apt-get clean \
