FROM ubuntu:14.04  
MAINTAINER Erik Osterman "e@osterman.com"  
ENV RSYNC_PASSWORD foobar  
  
RUN apt-get update && \  
apt-get -y install rsync  
  
ENTRYPOINT ["/usr/bin/rsync"]  
  

