# Use latest dwi67/jboss-fuse-6.3 image as the base  
FROM dwi67/jboss-fuse-6.3  
MAINTAINER Dieter Wijngaards <dieter.wijngaards@adesso.ch>  
  
# Copy the users properties to enable the console  
COPY users.properties /opt/jboss/jboss-fuse/etc/  

