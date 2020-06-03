FROM node:8.1.2-alpine  
ENV NODE_ENV production  
WORKDIR /usr/src/app  
COPY ["package.json", "npm-shrinkwrap.json*", "./"]  
RUN npm install --production --silent && mv node_modules ../  
COPY . .  
EXPOSE 3000  
CMD node app.js

