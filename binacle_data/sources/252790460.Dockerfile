FROM node:8.6-alpine  
  
RUN apk add --update git python make g++  
  
COPY . /app/  
WORKDIR /app  
  
RUN yarn install && yarn build && \  
apk del git python make g++ && \  
rm rm -rf /var/cache/apk/*  
  
EXPOSE 3000  
CMD node /app/lib/server.js  

