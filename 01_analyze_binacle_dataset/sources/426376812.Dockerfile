FROM ubuntu:12.04
#include "Maintainer"

#// A means of making sure the Docker image cache gets invalidated
#// every once in a while, if you need to completely
#// rebuild things. 
#//
#// Also possible with `docker --no-cache`
#// 
#// ENV LAST_UPDATED 2013-09-15
#//
#// Reference: http://crosbymichael.com/dockerfile-best-practices.html

#include "packages/Dockerfile.enable-apt-cache"
#include "Dockerfile.update-upgrade"
