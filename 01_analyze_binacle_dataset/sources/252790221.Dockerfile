FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install -y nodejs npm nodejs-legacy  
RUN npm install -g http-server  
  
# Add additional tools  
RUN apt-get install -y nano links git wget curl htop  
  
CMD http-server .  

