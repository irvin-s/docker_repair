FROM node:0.12.0-slim

MAINTAINER Curiosity driven <open-source@curiosity-driven.org>

WORKDIR /src
COPY package.json /src/
RUN npm install

COPY . /src

ENV PORT 3000
EXPOSE 3000

CMD ["npm", "start"]

