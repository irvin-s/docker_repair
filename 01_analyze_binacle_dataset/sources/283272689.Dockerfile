FROM node:8.1.2

ADD . /usr/src/app/server

WORKDIR /usr/src/app/server

RUN npm install

EXPOSE 3033 4033

CMD NODE_ENV=production npm start
