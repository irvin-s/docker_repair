FROM node:alpine  
  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
COPY . /Worker/  
  
WORKDIR "/Worker"  
  
EXPOSE 3000  
CMD [ "node", "index.js" ]  

