FROM node:alpine  
  
EXPOSE 3000  
WORKDIR /usr/src/ga-client  
COPY package.json .  
RUN npm install  
  
COPY . .  
  
CMD npm run-script build && npm start

