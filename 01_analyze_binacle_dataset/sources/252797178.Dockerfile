FROM ubuntu:14.04  
MAINTAINER Erik Osterman "e@osterman.com"  
ENV RSYNC_INTERVAL 0  
ENV RSYNC_PASSWORD foobar  
  
VOLUME /vol  
  
RUN apt-get update && \  
apt-get -y install rsync  
  
ADD /start /start  
  
ENTRYPOINT ["/start"]  
  

