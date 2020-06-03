FROM mono:5.4.1.6-slim  
MAINTAINER billypon  
  
RUN apt-get update && \  
apt-get install -y mono-fastcgi-server4 && \  
apt-get clean all && \  
  
sleep 0  

