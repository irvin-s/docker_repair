FROM node:latest  
  
MAINTAINER Alex Griessel <alex.griessel@consensys.net>  
  
# Global install yarn package manager  
RUN npm install -g --progress=false yarn  
  
WORKDIR /workspace  

