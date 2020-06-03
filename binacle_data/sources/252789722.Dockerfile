# Use latest dwi67/jboss-fuse-6.3-admin image as the base  
FROM dwi67/jboss-fuse-6.3-admin  
  
MAINTAINER Dieter Wijngaards <dieter.wijngaards@adesso.ch>  
  
USER root  
  
COPY fabric.sh /opt/jboss/jboss-fuse/fabric/fabric.sh  
COPY join.sh /opt/jboss/jboss-fuse/fabric/join.sh  
  
# Rearange rights  
COPY install.sh /opt/jboss/install.sh  
RUN /opt/jboss/install.sh  
  
USER jboss  
  
# The following directories can hold config/data  
#VOLUME /opt/jboss/jboss-fuse/instances  
#VOLUME /opt/jboss/jboss-fuse/tmp  
  
CMD /opt/jboss/jboss-fuse/fabric/fabric.sh

