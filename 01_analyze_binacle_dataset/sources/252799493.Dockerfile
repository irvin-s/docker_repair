FROM node:8  
WORKDIR /usr/src/app  
COPY package.json .  
COPY yarn.lock .  
  
RUN yarn  
  
COPY . .  
  
VOLUME /usr/src/app/config  
CMD ["npm", "start"]

