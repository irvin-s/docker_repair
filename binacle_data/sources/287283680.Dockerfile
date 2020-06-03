FROM mhart/alpine-node:7

RUN apk add --update \
    sqlite \
    && rm -rf /var/cache/apk/*

# Create app directory
RUN mkdir -p /home/node/wekan-gogs/data
WORKDIR /home/node/wekan-gogs

# Please don't run as root
RUN adduser -S node && chown -R node .
USER node

# Install app dependencies
COPY package.json .
RUN npm install

# Bundle app source
COPY . .

EXPOSE 7654
CMD [ "npm", "start" ]
