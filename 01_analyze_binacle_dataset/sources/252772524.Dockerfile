# Base Dockerfile for commander-registry  
# Extends registry  
FROM registry  
MAINTAINER Andrew Ellis <awellis@me.com>  
  
# Add Config  
ADD config/config.yml /config/config.yml  

