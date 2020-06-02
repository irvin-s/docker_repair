FROM python:3.5.2  
MAINTAINER Ceroic <ops@ceroic.com>  
  
# The majority of our projects also have a node requirement  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
  
RUN apt-get update && apt-get install -y \  
nodejs  
  
# Install some heavy node dependencies globally to speed up later builds  
RUN npm install -g phantomjs-prebuilt node-gyp babel bower  
  
# Make our application directory  
RUN mkdir -p /usr/src/app  
  
# Set the working directory to our application  
WORKDIR /usr/src/app  

