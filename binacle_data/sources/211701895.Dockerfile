FROM node:7

# Install dependencies
RUN npm install -g firebase
RUN npm install -g firebase-token-generator
RUN npm install -g firebase-tools

# Content setup
WORKDIR /usr/src/app/
ENV NODE_PATH=/usr/local/lib/node_modules
