FROM node:6.10.0  
RUN mkdir /usr/local/my-first-node-app  
COPY src/ /usr/local/my-first-node-app  
COPY package.json /usr/local/my-first-node-app  
  
WORKDIR /usr/local/my-first-node-app  
RUN yarn --production  
  
ENV NODE_ENV production  
ENTRYPOINT ["node", "bin/www"]  

