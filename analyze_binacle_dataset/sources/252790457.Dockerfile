FROM node:8.4-alpine  
  
COPY . /app/  
WORKDIR /app  
  
RUN apk add --update git python make g++ && \  
yarn install && yarn build && \  
apk del git python make g++ && \  
rm rm -rf /var/cache/apk/*  
  
EXPOSE 3000  
CMD node /app/lib/server.js  

