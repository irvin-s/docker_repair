FROM node

RUN apt-get update && apt-get install -y build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev

ADD package.json /dy/package.json

ADD server/ /dy/server

RUN cd /dy && npm install

WORKDIR /dy/server

EXPOSE 6565

CMD node server.js
