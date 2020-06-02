FROM node:7.8-alpine  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN apk add --no-cache git \  
&& npm install \  
&& apk del git  
  
COPY index.js /usr/src/app/  
  
EXPOSE 80  
CMD [ "node", "/usr/src/app/index.js" ]  

