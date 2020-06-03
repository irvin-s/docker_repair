FROM node:alpine  
  
RUN apk --no-cache update && \  
npm install jsonlint -g && \  
rm -rf /var/cache/apk/*  

