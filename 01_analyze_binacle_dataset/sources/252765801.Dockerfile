FROM node:alpine  
  
WORKDIR /usr/src/app  
COPY package.json ./package.json  
COPY yarn.lock ./yarn.lock  
RUN yarn  
COPY src ./src  
COPY config ./config  
  
ENV PORT 3000  
EXPOSE 3000  
CMD ["yarn", "start"]  

