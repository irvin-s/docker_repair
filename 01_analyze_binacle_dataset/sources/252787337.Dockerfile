FROM node:6  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
COPY bower.json /usr/src/app/  
RUN npm install --unsafe-perm  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 5000  
CMD [ "npm", "start" ]  

