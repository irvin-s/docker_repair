FROM node:latest

ADD . /app
WORKDIR /app

RUN npm install

CMD ["node", "server.js"]
