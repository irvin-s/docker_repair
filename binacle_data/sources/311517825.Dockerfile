FROM node:8.8.0-alpine

WORKDIR /api
EXPOSE 3000
CMD npm run start

ADD package.json /tmp/package.json
ADD yarn.lock /tmp/yarn.lock
RUN cd /tmp && yarn

RUN npm install -g pm2

ADD ./ /api
RUN mv /tmp/node_modules /api