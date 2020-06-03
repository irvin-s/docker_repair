FROM node:8-alpine  
  
ENV NODE_ENV production  
  
RUN mkdir /app  
WORKDIR /app  
COPY yarn.lock .  
COPY package.json .  
RUN yarn  
COPY ./ .  
RUN ln -s /app/bin/transifex-sync.js /usr/bin/transifex-sync  

