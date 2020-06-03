############################################################  
# Dockerfile to build DEV environment.  
# Copies the sentinel.conf file, as it's rewritten by the  
# sentinel process  
#  
# Based on Redis Alpine 3.0  
############################################################  
# Set the base image to Ubuntu  
FROM redis:3.0-alpine  
  
MAINTAINER cgarciaarano@gmail.com  
  
# Add requirements  
COPY dockerfiles/dev/sentinel/sentinel.conf /etc/redis/sentinel.conf  

