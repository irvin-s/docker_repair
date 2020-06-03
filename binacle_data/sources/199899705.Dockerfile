FROM debian:jessie
MAINTAINER Alexander Fedyashov <a@fedyashov.com>

ADD default-release /etc/apt/apt.conf.d/default-release
ADD preferences /etc/apt/preferences
ADD stretch.list /etc/apt/sources.list.d/

RUN apt-get update && apt-get install -y --force-yes \
    build-essential git \
    devscripts debhelper fakeroot cdbs \
    sudo

RUN echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV LC_ALL="C.UTF-8" LANG="C.UTF-8"

# Install dependencies to speed up builds

RUN apt-get install -y \
    libgumbo-dev libxml2-dev php5-dev
