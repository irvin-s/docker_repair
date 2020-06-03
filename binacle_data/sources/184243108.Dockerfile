# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Debian Stable image based on debian:jessie
# TO_BUILD:       docker build --rm -t airdock/base .
# SOURCE:         https://github.com/airdock/docker-base

# Pull base image.
FROM debian:jessie
MAINTAINER Jerome Guibert <jguibert@gmail.com>

USER root

# Never prompts the user for choices on installation/configuration of packages
# No dialog on apt-get update
# Work around initramfs-tools running on kernel 'upgrade': <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189>
# Define en_US.


ENV DEBIAN_FRONTEND=noninteractive \
    TERM=linux \
    INITRD=No \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8  \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_MESSAGES=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    GOSU_VERSION=1.9 \
    TINI_VERSION=v0.13.2


#add root asset (aliases and fix user id)
ADD asset/* /root/


# Install curl, locales, apt-utils, gosu and tini
# create en_US.UTF-8
# update distribution package
# add few common alias to root user
# add utilities (create user, post install script)
# create airdock user list
RUN set -x && \
  apt-get update -qq && \
  apt-get install -y apt-utils curl locales && \
  apt-get install -y --no-install-recommends ca-certificates wget && \
  sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen && \
  update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
  apt-get update -y && \
  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"  && \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"  && \
  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"  && \
  export GNUPGHOME="$(mktemp -d)"  && \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4  && \
  gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu  && \
  rm -r /usr/local/bin/gosu.asc  && \
  chmod +x /usr/local/bin/gosu  && \
  gosu nobody true  && \
  wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini" && \
  wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc" && \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
  gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini  && \
  rm -r "$GNUPGHOME" /usr/local/bin/tini.asc  && \
  chmod +x /usr/local/bin/tini  && \
  apt-get purge -y --auto-remove ca-certificates wget  && \
  mv /root/aliases /root/.aliases && \
  echo "source ~/.aliases" >> /root/.bashrc && \
  /root/create-user redis 4201 redis 4201  && \
  /root/create-user elasticsearch 4202 elasticsearch 4202 && \
  /root/create-user mongodb 4203 mongodb 4203 && \
  /root/create-user rabbitmq 4204 rabbitmq 4204 && \
  /root/create-user java 4205 java 4205 && \
  /root/create-user py 4206 py 4206 && \
  /root/create-user node 4207 node 4207 && \
  /root/create-user docker 4242 docker 4242 && \
  /root/post-install

# Define default workdir
WORKDIR /root

# Define default command.
CMD [ "/bin/bash", "-l"]
