FROM node:9.11.1-alpine  
RUN apk add \--no-cache chromium  
RUN apk add \--no-cache udev ttf-freefont  
RUN npm install --no-cache -g yarn && chmod +x /usr/local/bin/yarn  
RUN apk add \--no-cache git  

