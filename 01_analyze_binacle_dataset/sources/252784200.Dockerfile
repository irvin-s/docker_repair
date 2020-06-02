FROM node:6-slim  
  
MAINTAINER Birkhoff Lee <admin@birkhoff.me>  
  
ADD build.sh /  
ADD run.sh /  
RUN chmod +x /build.sh /run.sh  
  
WORKDIR ~  
RUN export NODE_ENV=production; \  
npm i -g forever coffee-script  
  
CMD [ "coffee" ]  

