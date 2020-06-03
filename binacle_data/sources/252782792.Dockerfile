FROM david6miji/gulp-tool:latest  
  
MAINTAINER David You <david6miji@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Loopback  
RUN npm install -g strongloop  
  

