###########################################################  
# Dockerfile to build an nginx webserver  
# Based on Ubuntu  
###########################################################  
  
FROM ubuntu:14.04  
MAINTAINER chitter99 docker-automate-building  
  
################## BEGIN INSTALLATION ######################  
  
RUN apt-get update  
RUN apt-get -y install nginx  
  
##################### INSTALLATION END #####################  
  
# Expose the default ports  
EXPOSE 80  
EXPOSE 443  
  
# Start nginx as default  
CMD ["nginx", "-g", "daemon off;"]

