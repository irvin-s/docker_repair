FROM node:alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

ADD index.js ./

ADD package.json ./

RUN npm install

CMD ["npm", "start"]