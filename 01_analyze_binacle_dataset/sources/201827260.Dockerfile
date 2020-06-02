FROM node:6
MAINTAINER Brandfolder, Inc. <developers@brandfolder.com>

# Set up ENV
ENV NPM_CONFIG_LOGLEVEL warn
ENV BRANDFOLDER_API_ENDPOINT https://api.brandfolder.com/v2
ENV PORT 5000

# Set the working directory
WORKDIR /app

# Expose the PORT
EXPOSE $PORT

# Install Packages
ADD package.json /app/package.json
RUN npm install

# Install App
ADD . /app

# Start the app
CMD npm start
