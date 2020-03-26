FROM node:7.9.0-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD package.json /usr/src/app/
RUN npm install && npm cache clean
ADD . /usr/src/app

CMD [ "npm", "start" ]

EXPOSE 3000
