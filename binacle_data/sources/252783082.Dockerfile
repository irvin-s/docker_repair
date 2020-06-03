FROM node:carbon  
  
# Create app directory  
WORKDIR /usr/src/app  
  
COPY package*.json ./  
  
RUN npm install  
RUN npm install knex -g  
RUN knex migrate:latest && knex seed:run  
  
COPY . .  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

