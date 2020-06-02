FROM node:10-alpine  
RUN mkdir -p /diary  
WORKDIR /diary  
COPY yarn.lock yarn.lock  
COPY package.json package.json  
RUN yarn  
COPY src src  
ENTRYPOINT ["node", "src/bin.js"]  

