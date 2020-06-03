FROM node:4.2
MAINTAINER Josh Finnie <josh@jfin.us>

RUN npm install -g pm2@0.15.10

WORKDIR /code/

ADD package.json /code/package.json
RUN npm install --production
ADD app /code/app

CMD pm2 start /code/app/app.json --no-daemon
