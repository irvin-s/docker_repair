FROM node:8.1.0-alpine  
MAINTAINER Jonathan Griggs <jonathan.griggs@gmail.com>  
ADD /src /app  
WORKDIR /app  
RUN npm install  
CMD ["node", "index.js"]  

