# BUILDING
# docker build -t stuckless/sagetv-build:latest .
#
# RUNNING (ie, rebuild sagetv)
# docker run -t -v /home/seans/docker/sagetv-build/SOURCES:/build --name sagetv-server stuckless/sagetv-build
#
# Thanks to coppit, since his sagetv docker container was the basis for this

FROM ubuntu:14.04.4

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

ENV APP_NAME="SageTV Builder"
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Install dependencies
RUN set -x && apt-get update \
    && apt-get install -y unzip \
        python-software-properties software-properties-common \
        build-essential \
        git \
        libx11-dev libxt-dev libraw1394-dev libavc1394-dev libiec61883-dev \
        libfreetype6-dev yasm autoconf libtool \
        libaudio-dev libpulse-dev libasound-dev liba52-dev

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# these env vars remain persistent when the image is run
ENV JAVA_ARCH="amd64"
#ENV JDK_HOME="/usr/lib/jvm/java-8-openjdk-$JAVA_ARCH/"
ENV JDK_HOME /usr/lib/jvm/java-8-oracle
ENV SAGETV_REPO="https://github.com/google/sagetv.git"
ENV PUID=1000
ENV GUID=1000

RUN mkdir /build

ADD buildsage.sh /usr/bin/

# need to passed on the command line as the place to fetch and build the source
# -v full_path_to_local_empty_dir_where_sources_will_be_built:/build
VOLUME ["/build"]

WORKDIR /build

CMD /usr/bin/buildsage.sh

