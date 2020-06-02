FROM node:6.10.1-slim  
  
ARG bowerVersion=1.8.0  
  
MAINTAINER Leo Schweizer <leonhard.schweizer@d-labs.com>  
  
RUN apt-get update \  
&& apt-get install -y git \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN npm install -g bower@${bowerVersion}  

