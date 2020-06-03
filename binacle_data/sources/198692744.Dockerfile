FROM node:4
MAINTAINER Fabian Köster <koesterreich@fastmail.fm>

# Copy over package.json
ADD package.json ./

# Install dependencies
RUN npm install --silent

# Copy over remaining sources
ADD . ./

# Start the web application server
CMD node server.js

# The port(s) the web application uses
EXPOSE 5000

VOLUME /data
