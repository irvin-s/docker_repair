FROM ubuntu:yakkety
MAINTAINER Claudio Ramirez <pub.claudio@gmail.com>

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Brussels
ENV pkgs ruby-dev build-essential wget lsb-release git

RUN set -xv ; \
apt-get -qq update && \
apt-get -qq dist-upgrade -y && \
# pkgs for compiling and pkg creation
apt-get -qq install -y ${pkgs} ${pkgs_tmp} && \
gem install fpm && \
# Cleanup
apt-get -qq autoremove -y && \
apt-get -qq clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /*.deb /MoarVM* /nqp* /rakudo*

COPY pkg_rakudo.pl /
COPY install-zef-as-user /

CMD '/pkg_rakudo.pl'
