FROM ubuntu:16.04  
MAINTAINER ARC-TS <arcts-dev@umich.edu>  
  
ARG BUILD_DATE  
ARG SINGULARITY_VERSION  
ARG VCS_REF  
ARG VERSION  
  
LABEL architecture="x86_64" \  
build-date="$BUILD_DATE" \  
license="MIT" \  
name="arcts/singularity-util" \  
summary="Docker based wrapper for Singularity" \  
version="$VERSION" \  
vcs-ref="$VCS_REF" \  
vcs-type="git" \  
vcs-url="https://github.com/arc-ts/singularity-util" \  
singularity.version="$SINGULARITY_VERSION"  
  
RUN apt-get update \  
&& apt-get -y install \  
autoconf \  
automake \  
autotools-dev \  
build-essential \  
debootstrap \  
debhelper \  
dh-autoreconf \  
git \  
libtool \  
python \  
rpm \  
sudo \  
&& mkdir build \  
&& mkdir target \  
&& apt-get -y autoremove \  
&& apt-get -y clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY ./skel /  
  
RUN chmod +x ./build.sh \  
&& sync \  
&& chmod +x ./init.sh \  
&& sync \  
&& ./build.sh  
  
ENTRYPOINT [ "./init.sh" ]  

