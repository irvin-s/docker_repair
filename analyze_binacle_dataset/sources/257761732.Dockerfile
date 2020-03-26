FROM node:latest

LABEL name="node-microservice-with-docker-in-30mins"

WORKDIR /tmp
COPY ./package.json package.json
COPY ./index.js index.js

RUN npm install

EXPOSE 8080

CMD ["node", "index.js"]