FROM node:alpine  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src  
  
ADD package.json .  
ADD yarn.lock .  
  
RUN yarn && yarn cache clean  
  
ENV PATH /usr/src/node_modules/.bin:$PATH  
  
WORKDIR /usr/src/app  
  
COPY . .  
  
EXPOSE 3000  
CMD yarn build && yarn start

