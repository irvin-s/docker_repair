FROM ubuntu:14.04  
RUN apt-get update && \  
apt-get install -y nodejs && \  
apt-get install -y npm  
  
RUN npm install express  
  
RUN mkdir /nodejs  
ADD Nodejs /nodejs/  
  
WORKDIR "/nodejs/"  
  
EXPOSE 3000  
CMD nodejs server.js  
  

