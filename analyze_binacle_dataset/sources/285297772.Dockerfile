FROM node:alpine

#Create app directory
WORKDIR /usr/src/app

#Copy package.json & package.lock.json
COPY package*.json ./

#Install
RUN npm install --only=production

#Copy remainder of app source files
COPY . .

#Expose ports
EXPOSE 9111

# Start Service
cmd [ "node", "boot.js" ]
