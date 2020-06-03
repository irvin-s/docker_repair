FROM node:6-slim  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
  
# Building front end assets  
RUN npm install && npm run build && rm -r node_modules && npm cache clean  
  
# Switching to server folder and installing server packages  
WORKDIR /usr/src/app/server  
RUN npm install  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

