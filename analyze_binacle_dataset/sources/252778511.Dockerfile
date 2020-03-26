FROM node:10.2.1-alpine  
  
WORKDIR /usr/src/app  
COPY package.json yarn.lock ./  
RUN yarn install --production  
COPY . .  
  
EXPOSE 3000  
CMD [ "npm", "start" ]

