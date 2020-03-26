FROM node:7.10.0-alpine  
ENV NODE_ENV=production  
RUN mkdir -p /usr/src/wowanalyzer  
COPY . /usr/src/wowanalyzer  
WORKDIR /usr/src/wowanalyzer  
RUN npm install  
USER node  
CMD [ "node", "server/index.js" ]  

