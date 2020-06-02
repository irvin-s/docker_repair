FROM stackbrew/busybox:latest  
MAINTAINER David Bain <david@alteroo.com>  
  
# Create data directory  
RUN mkdir -p /opt/plone/app/var  
  
# Create /data volume  
VOLUME /opt/plone/app/var  

