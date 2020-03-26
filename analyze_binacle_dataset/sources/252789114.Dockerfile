FROM debian:jessie  
MAINTAINER dsheyp  
  
RUN apt-get update && \  
apt-get install -y --force-yes fslint fdupes && \  
apt-get clean  
  
RUN mkdir /homes  
  
VOLUME /homes

