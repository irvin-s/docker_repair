# Version: 0.0.2  
FROM ubuntu:xenial  
  
MAINTAINER codeyu <codeyu@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
ENV REFRESHED_AT 2017-06-04  
RUN cp /etc/apt/sources.list /etc/apt/sources.list.backup  
  
RUN rm /etc/apt/sources.list  
  
COPY sources.list /etc/apt/  
  
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils  
  
ENV DEBIAN_FRONTEND teletype

