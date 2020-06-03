FROM node:latest

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# Build static file
RUN npm install
RUN npm run build

WORKDIR /usr/src/app/server

# Bundle app source
EXPOSE 3000
CMD [ "npm", "start" ]