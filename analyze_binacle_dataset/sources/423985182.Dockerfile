FROM node:10-alpine

WORKDIR /home/app

# Get and install dependencies
COPY package.json .
RUN NPM_CONFIG_LOGLEVEL=warn npm install --production

# Copy the actual code
COPY . .
RUN chown 1000:1000 -R /home/app

USER 1000:1000
