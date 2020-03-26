# Pull base image.  
FROM ubuntu:vivid  
MAINTAINER Erik Dasque <erik@frenchguys.com>  
  
# Install base packages  
RUN apt-get update  
RUN apt-get upgrade -y  
  
VOLUME ["/data"]  
  
# Define working directory.  
WORKDIR /data  
  
ADD file_generator.sh /file_generator.sh  
RUN chmod +x /file_generator.sh  
  
CMD while [ 1 ] ; do /file_generator.sh; sleep 120 ; done  

