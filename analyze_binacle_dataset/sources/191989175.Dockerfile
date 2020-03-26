FROM peihsinsu/alpine-nodejs-express

ADD ./socket-server /app
WORKDIR /app

CMD ["node", "server.js"]
