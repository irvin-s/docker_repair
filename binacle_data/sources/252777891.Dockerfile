FROM node:latest  
  
RUN \  
npm install turf-cli -g  
  
WORKDIR /data  
VOLUME ["/data"]  
  
USER nobody  
  
CMD turf -help  

