FROM node:6.5.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY . /usr/src/app

EXPOSE 3100

# Resolve dependencies at container startup to allow caching
CMD npm install && node_modules/.bin/nodemon ./bin/www