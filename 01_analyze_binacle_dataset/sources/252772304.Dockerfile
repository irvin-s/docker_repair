FROM node:8.9-alpine  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash git openssh && \  
npm i -g nodemon  

