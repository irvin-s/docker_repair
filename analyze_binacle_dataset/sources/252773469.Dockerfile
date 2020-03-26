## Base image to use  
FROM ubuntu:14.04  
## Maintainer info  
MAINTAINER amuteau <https://github.com/amuteau>  
  
  
  
## Update base image and install prerequisites  
#ENV http_proxy 'http://10.239.9.20:80'  
#ENV https_proxy 'http://10.239.9.20'  
RUN apt-get update  
RUN apt-get install -y curl git python bash libpq-dev libqtgui4 libqtcore4  
  
## Set working directory  
WORKDIR /opt  
  
## Run batch  
ENTRYPOINT ["/opt/start"]  

