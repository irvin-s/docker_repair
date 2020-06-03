# Install base image
FROM readytalk/nodejs:latest

# Install app dependencies
COPY package.json /src/package.json
RUN cd /src; npm install

# Install app source
COPY . /src

# Start app
CMD node /src/index.js
