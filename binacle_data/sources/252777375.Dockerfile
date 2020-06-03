FROM node:6-alpine  
ENV NODE_ENV production  
WORKDIR /usr/src/app  
COPY ["package.json", "npm-shrinkwrap.json*", "./"]  
RUN npm install --production --silent && mv node_modules ../  
COPY . .  
EXPOSE 4004  
CMD node index.js

