from ubuntu:latest  
  
MAINTAINER Eric Greene <eric@training4developers.com>  
  
ENV NODE_VERSION 6.2.1  
ENV NODE_ARCHIVE node-v$NODE_VERSION-linux-x64.tar.xz  
  
# Update & Install Ubuntu Packages  
RUN apt-get update && apt-get install -y \  
curl \  
xz-utils && \  
mkdir /opt/downloads; mkdir /opt/app && \  
curl -o /opt/downloads/$NODE_ARCHIVE \  
https://nodejs.org/dist/v$NODE_VERSION/$NODE_ARCHIVE && \  
tar -C /usr/local --strip-components 1 -xf /opt/downloads/$NODE_ARCHIVE  
  
EXPOSE 3000  

