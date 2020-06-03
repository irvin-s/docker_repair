FROM node:8-alpine  
  
# Install Git (for bower)  
RUN apk add --update git \  
&& rm -rf /var/cache/apk/*  
  
# Install bower & gulp  
RUN npm install -g bower gulp-cli  
  
# Create app directory owned by a non-admin user  
RUN mkdir -p /usr/src/app  
RUN adduser -D -u 1001 build  
RUN chown build:build /usr/src/app  
  
USER build  
WORKDIR /usr/src/app  
  
# Install dependencies  
COPY package.json /usr/src/app/package.json  
RUN npm install  
  
USER root  
ENV NODE_ENV="production"  

