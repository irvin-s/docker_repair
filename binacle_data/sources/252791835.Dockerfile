FROM node:8-alpine  
  
WORKDIR /app  
RUN apk add \--no-cache git python make g++  
  
COPY package.json yarn.lock ./  
RUN chown node:node /app  
  
#Switch to node user for security  
USER node  
  
RUN yarn install --frozen-lockfile  

