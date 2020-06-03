FROM node:8-alpine  
  
EXPOSE 8080  
WORKDIR /app  
  
RUN apk add --update \  
openssl \  
&& rm -rf /var/cache/apk/*  
  
ADD package.json yarn.lock /app/  
RUN yarn install  
  
ADD index.js default-conf.js /app/  
  
CMD node index.js  

