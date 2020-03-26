FROM node:6  
MAINTAINER Tõnis Tobre <tobre@bitweb.ee>  
  
ADD . /app  
  
WORKDIR /app  
  
RUN mv docker/default.js config/default.js  
  
EXPOSE 80  
RUN npm install  
  
CMD ["node", "index.js"]  

