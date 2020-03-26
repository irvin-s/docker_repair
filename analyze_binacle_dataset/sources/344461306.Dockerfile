FROM node:0.12
MAINTAINER Meteorhacks

COPY ./package.json /app/package.json
RUN cd /app && npm install
COPY . /app

CMD ["node", "/app/index.js"]
