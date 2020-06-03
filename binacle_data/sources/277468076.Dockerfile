FROM node:latest

# File Author / Maintainer
MAINTAINER Lola Rigaut-Luczak

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# For npm@5 or later, copy package-lock.json as well
COPY package.json package-lock.json ./
# Bundle app source
COPY . .

RUN npm install

CMD [ "npm", "start" ]
