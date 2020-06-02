FROM node:8.12.0-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV NODE_ENV development
RUN npm install -g nodemon

EXPOSE 80

CMD nodemon -V -L --ignore 'index.html' --watch ./packages/server -e html,js,json packages/server/index.js
# add '--inspect=0.0.0.0:5858' to debug the server
