FROM node:latest  
  
# Create app directory  
WORKDIR /usr/src/app  
  
COPY . .  
  
RUN npm install  
  
EXPOSE 3000  
CMD [ "npm", "run", "start" ]

