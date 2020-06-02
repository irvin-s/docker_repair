FROM node:latest

WORKDIR /home/api
ADD . /home/api

RUN npm install

EXPOSE 8888

CMD npm run prod
