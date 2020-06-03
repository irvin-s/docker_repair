FROM node:alpine as builder  
  
RUN apk --update --no-cache add --virtual build-dependencies git  
  
WORKDIR /src  
COPY package.json ./  
RUN apk --update --no-cache add --virtual build-dependencies git && \  
npm install && \  
apk del build-dependencies  
COPY ./ ./  
  
RUN mkdir -p ./public/javascripts && npm run bundle  
  
FROM nginx:alpine  
  
COPY \--from=builder /src/public /usr/share/nginx/html/

