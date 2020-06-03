FROM node:boron  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
RUN npm install apidoc -g  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 3000  
RUN apidoc -i app/routes -o doc/assets/api -t doc/sections/api  
CMD [ "npm", "start" ]  
  

