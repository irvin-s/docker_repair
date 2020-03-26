FROM ubuntu:14.04  
MAINTAINER Doug Goldstein <cardoe@cardoe.com>  
  
ENV DEBIAN_FRONTEND=noninteractive  
ENV USER root  
  
RUN mkdir /source  
  
# build depends  
RUN apt-get update && \  
apt-get --quiet --yes install \  
build-essential zlib1g-dev libncurses5-dev libssl-dev python2.7-dev \  
xorg-dev uuid-dev libyajl-dev libaio-dev libglib2.0-dev clang \  
libpixman-1-dev pkg-config flex bison gettext acpica-tools bin86 \  
bcc libc6-dev-i386 libnl-3-dev ocaml-nox libfindlib-ocaml-dev \  
markdown transfig pandoc checkpolicy wget git && \  
apt-get autoremove -y && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*  
  
# where we build  
VOLUME ["/source"]  
WORKDIR /source  
CMD ["/bin/bash"]  

