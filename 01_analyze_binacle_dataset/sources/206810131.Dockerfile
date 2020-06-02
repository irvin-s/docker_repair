FROM node:boron

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy Source
COPY ./dist/release /usr/src/app/

# Install app dependencies
RUN npm install --only=production

# Declare environment variables
ENV NODE_ENV production

# Run
CMD [ "node", "server.js" ]
