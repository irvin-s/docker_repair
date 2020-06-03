FROM node:carbon-alpine

MAINTAINER @the-vladman

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Bundle app source
COPY . .

EXPOSE 9000

CMD [ "npm", "run", "prod" ]
