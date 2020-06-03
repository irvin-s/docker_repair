FROM node:8.8.0-alpine

WORKDIR /admin
EXPOSE 3000
CMD npm run start

ADD package.json /tmp/package.json
ADD yarn.lock /tmp/yarn.lock
RUN cd /tmp && yarn

ADD ./ /admin
RUN mv /tmp/node_modules /admin

RUN npm run build