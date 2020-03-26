FROM node:8.7.0-alpine

# we are gonna compile using webpack at buildtime so we need these env vars
ARG API_ROUTE_PREFIX
ARG API_CALL_TIMEOUT_MS
ARG CHECK_AUTH_INTERVAL_MS

RUN apk add --no-cache python gcc g++ make git

RUN mkdir /log

# install ui dependencies
WORKDIR /app/ui
COPY package.json /app/ui/package.json
COPY package-lock.json /app/ui/package-lock.json
RUN npm install

# add ui source code
COPY src/ /app/ui/src/

# compile VueJS code
RUN npm run build

# start production ui server
CMD ["npm", "run", "start:prod"]
