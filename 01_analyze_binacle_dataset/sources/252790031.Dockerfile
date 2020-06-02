# This Dockerfile is used to build a Docker image. That image can be converted  
# to a Singularity image for use on OpenMind.  
# A Dockerfile must specify a base image. In this case, we will use the  
# golang version 1.8.3 Docker image as our base. It is based on Debian, and Go  
# will already be installed. We can use apt-get to install other packages.  
# (Any Docker image can be used as a base. For example, to build on Ubuntu 17,  
# you could have specified ubuntu:17.04. See https://hub.docker.com/ for  
# images that are available on DockerHub)  
FROM golang:1.8.3  
# Install libraries as you would on a Debian machine. Remember that the golang  
# base image is built on a debian image.  
RUN apt-get update -qq \  
&& apt-get install -yq cmake \  
golang\  
fceux \  
gcc \  
libboost-all-dev \  
libjpeg-dev \  
libjpeg62-turbo-dev \  
libsdl2-dev \  
make \  
unzip \  
wget \  
zlib1g-dev  
  
# This will be the default command when running this container.  
ENTRYPOINT ["/usr/local/go/bin/go"]  

