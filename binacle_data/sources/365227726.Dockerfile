FROM node:5

MAINTAINER Andrew Reddikh <andrew@reddikh.com>

# Define working directory
WORKDIR /app

ADD package.json /app/package.json

# Install dependencies updates
RUN npm install

# Set env
ENV PATH=/usr/local/bin:/bin:/usr/bin:/app/node_modules/phantomjs-prebuilt/bin

ADD ./lib /app/lib

CMD ["node", "lib/index.js"]
