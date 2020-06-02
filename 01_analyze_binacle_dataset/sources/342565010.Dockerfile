FROM node:8.7.0-alpine

RUN apk add --no-cache python gcc g++ make git \
# we use nodemon to auto-restart the server when serverside code changes
    && npm install nodemon -g

RUN mkdir /log

# install api dependencies
WORKDIR /app/api
COPY package.json /app/api/package.json
COPY package-lock.json /app/api/package-lock.json
RUN npm install

# add api source code
COPY src/ /app/api/src/

# start development api server
CMD ["npm", "run", "start:dev"]
