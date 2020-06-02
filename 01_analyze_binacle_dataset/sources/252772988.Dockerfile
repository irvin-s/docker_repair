FROM node:8.4-alpine  
MAINTAINER Surya Widi Kusuma <neversleepman@tfwno.gf>  
  
WORKDIR /usr/src/app  
COPY package.json yarn.lock ./  
RUN yarn install  
COPY . .  
  
EXPOSE 9100  
ENV NODE_ENV=production  
CMD [ "yarn", "start" ]

