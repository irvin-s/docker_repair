FROM ubuntu:14.04.1  
MAINTAINER Adam Israel <adam@adamisrael.com>  
RUN apt-get update && apt-get -y --no-install-recommends install \  
bzr \  
ca-certificates \  
git \  
golang-go \  
golang-src \  
mercurial \  
make \  
openssh-client  
  
ENV HOME=/home/ubuntu  
ENV GOPATH=/home/ubuntu/go  
ENV GOROOT=/usr/lib/go  
# ENV JUJU_DEV_FEATURE_FLAGS=action  
# Setup the user  
ADD setup.sh /  
RUN /setup.sh  
  
# Setup directories  
RUN mkdir -p /home/ubuntu/.juju  
RUN mkdir -p /home/ubuntu/.go  
  
# Make ~.juju persistent  
# This will need a local directory, mapped to via docker run  
VOLUME ["/home/ubuntu/.juju"]  
  
ADD juju.sh /  
ADD run.sh /  
  
# Disable lxc until it's functional  
# ADD lxc.sh /  
# RUN /lxc.sh  
RUN /juju.sh  
CMD /run.sh  

