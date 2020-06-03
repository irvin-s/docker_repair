FROM nodesource/node:trusty  
  
MAINTAINER Andrii Chyzh <info.andriichyzh@gmail.com>  
  
ADD app .  
  
RUN npm install  
  
EXPOSE 8080  
ENTRYPOINT ["node", "index.js"]  

