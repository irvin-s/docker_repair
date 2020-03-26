#https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
FROM node:boron

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

EXPOSE 8081
CMD [ "npm", "start" ]