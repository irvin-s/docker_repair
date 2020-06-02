  
# Nodejs-Build Dockerfile  
# VERSION 8.9  
#  
# Pull Alpine Linux stable base image  
FROM quay.io/appelgriebsch/alpine-sdk:3.7  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="nodejs-build"  
LABEL VERSION="8.9"  
  
# add updated startup-scripts  
COPY scripts/*.sh /tmp/scripts/  
COPY start_instance.sh /tmp/  
RUN \  
chmod 755 /tmp/start_instance.sh  

