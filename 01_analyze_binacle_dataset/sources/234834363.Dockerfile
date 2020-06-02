FROM mhart/alpine-node:latest

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json ./
RUN yarn install

# Bundle app source
COPY . .

RUN addgroup -S app -g 50000 && \
    adduser -S -g app -u 50000 app && \
    mkdir /data && chown app:app /data/

USER app

ENTRYPOINT [ "node", "src/server.js" ]
