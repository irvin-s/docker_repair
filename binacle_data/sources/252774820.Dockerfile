FROM node:6.9.4  
VOLUME /site/wwwroot  
WORKDIR /site/wwwroot  
EXPOSE 80  
RUN apt-get update  
RUN apt-get install lftp  
  
RUN npm install -g angular-cli  

