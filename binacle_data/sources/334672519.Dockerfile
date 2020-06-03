FROM node:11-alpine

WORKDIR /opt/app

# copy requirements
COPY package*.json ./

# install build tools
RUN apk add -qU --no-cache -t .fetch-deps git make python g++ \
    && npm install -g npm@latest \
    && npm i \
    && apk del -q .fetch-deps

# copy the code
COPY . .

# transpile typescript
RUN npm run transpile

# set build meta data
ARG BUILD_COMMIT
ARG BUILD_TIMESTAMP

ENV BUILD_COMMIT $BUILD_COMMIT
ENV BUILD_TIMESTAMP $BUILD_TIMESTAMP

EXPOSE 80
HEALTHCHECK --interval=1m --timeout=5s --retries=3 CMD wget localhost/status -q -O - > /dev/null 2>&1

# run the api server
CMD [ "npm", "run", "start" ]
