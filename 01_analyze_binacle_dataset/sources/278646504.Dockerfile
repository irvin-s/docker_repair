FROM node:8

ENV PORT 8080
EXPOSE 8080

COPY index.js index.js
COPY package.json package.json

RUN yarn install

CMD yarn start
