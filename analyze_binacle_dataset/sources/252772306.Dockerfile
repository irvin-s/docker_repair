FROM node:6-slim  
  
MAINTAINER Dominik Hahn <dominik@monostream.com>  
  
# Install dependencies  
RUN apt-get -yqq update && \  
apt-get -yqq --no-install-recommends install git && \  
apt-get -yqq install libpng-dev && \  
npm install -g pngquant-bin && \  
npm install -g @angular/cli gulp bower yarn && \  
npm cache clean && \  
apt-get -yqq autoremove && \  
apt-get -yqq clean && \  
rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/tmp/*  
  
# Define working directory.  
WORKDIR /workspace

