FROM ubuntu:14.04  
MAINTAINER Esben Haabendal, eha@deif.com  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update -qq \  
&& apt-get install -qq -y \  
build-essential ssh-client git subversion curl wget smbclient \  
check psmisc bc tofrodos \  
autoconf automake libtool gettext autoconf-archive pkg-config \  
doxygen \  
libjansson-dev \  
zlib1g-dev \  
ruby bundler \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# /bin/sh should be bash  
RUN echo "dash dash/sh boolean false" | debconf-set-selections \  
&& dpkg-reconfigure dash  
  
# Install skalibs  
RUN git clone https://github.com/skarnet/skalibs.git \  
&& cd skalibs \  
&& git checkout v2.6.2.0 \  
&& ./configure \  
&& make install \  
&& cd .. \  
&& rm -rf skalibs  

