FROM node:6

WORKDIR /usr/src/app

# Copy streen (just the files we need)
COPY server.js /usr/src/app/server.js
COPY package.json /usr/src/app/package.json
COPY lib /usr/src/app/lib

# Install dependencies
RUN npm install --production

# The command to run
CMD ["node", "server.js"]
