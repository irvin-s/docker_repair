FROM busybox:latest  
MAINTAINER Michael Davis michael@damaru.com  
  
# Create data directory  
RUN mkdir /data  
  
# Create /data volume  
VOLUME /data  

