FROM node:alpine  
MAINTAINER Adilson Carvalho <lc.adilson@gmail.com>  
  
RUN mkdir -p /{yakbak,tapes} && npm install yakbak --save-dev  
  
VOLUME /tapes  
  
WORKDIR /yakbak  
COPY . .  
  
EXPOSE 7000  
ENTRYPOINT ["node", "proxy.js"]  

