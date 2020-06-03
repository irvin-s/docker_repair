FROM node:alpine  
  
WORKDIR /  
COPY package.json yarn.lock /  
RUN yarn install  
  
ENTRYPOINT ["/queen/queen.js"]  
COPY binstubs/* bin/  
  
COPY ./queen /queen  

