FROM node:8.11.3-alpine

WORKDIR /app

ADD . /app

CMD ["node","evaluate.js"]
