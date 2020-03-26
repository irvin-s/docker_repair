FROM node:8  
COPY package-lock.json package.json /tmp/  
RUN cd /tmp && npm install  
RUN mkdir -p /build && cp -a /tmp/node_modules /build  
COPY . /build  
WORKDIR /build  
RUN npm run-script build  
  
FROM nginx:alpine  
MAINTAINER Arunderwood  
COPY nginx/nginx.conf /etc/nginx/nginx.conf  
COPY \--from=0 /build/dist /usr/share/nginx/html  

