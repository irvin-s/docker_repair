FROM node:8.5.0-stretch  
  
MAINTAINER "Daithi Coombes" <webeire@gmail.com>  
  
WORKDIR /usr/src/app  
COPY package.json package-lock.json ./  
COPY bower.json .bowerrc ./  
  
RUN npm install  
RUN node node_modules/.bin/bower install --allow-root  
  
COPY . .  
EXPOSE 3000  
CMD ["npm", "start"]  

