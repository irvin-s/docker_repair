# Docker image for running AWS DynamoDB local instance  
#  
# Includes OpenJDK 7 as well as latest Jar binary of DynamoDB  
# DynamoDB runs under supervisor process  
FROM ubuntu:14.04  
MAINTAINER Patrick McClory <patrick@dualspark.com>  
  
COPY install.sh /tmp/  
  
COPY supervisor.docker.sh /tmp/  
  
RUN \  
sudo chmod +x /tmp/install.sh && \  
sudo bash /tmp/install.sh && \  
sudo bash /tmp/supervisor.docker.sh  
  
EXPOSE 8000  
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf  

