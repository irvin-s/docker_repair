FROM node:4.2.2-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install --quiet
COPY . /usr/src/app

RUN npm run build

CMD PORT=3000 NODE_ENV=production npm start
