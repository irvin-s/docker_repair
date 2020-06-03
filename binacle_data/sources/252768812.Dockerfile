FROM node:6-alpine  
MAINTAINER Andre Metzen <metzen@conceptho.com>  
  
WORKDIR /src  
ADD . .  
RUN npm install  
  
CMD ["node", "index.js"]

