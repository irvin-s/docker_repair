FROM node:6.5.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY . /usr/src/app

EXPOSE 3002

CMD npm install && npm start