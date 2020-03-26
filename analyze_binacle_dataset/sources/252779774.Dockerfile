FROM node:5  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY index.js /usr/src/app  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

