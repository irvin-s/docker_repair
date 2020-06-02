FROM node:7.10.0-alpine
MAINTAINER Matheus Fidelis <msfidelis01@gmail.com>

RUN mkdir -p /app
COPY src /app

WORKDIR /app

RUN npm install

CMD ["npm", "start"]
