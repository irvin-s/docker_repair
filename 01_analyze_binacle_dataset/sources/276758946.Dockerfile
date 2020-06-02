FROM node:8.9.3-alpine

RUN yarn global add serve

ADD package.json /src/package.json
ADD yarn.lock /src/yarn.lock

RUN cd /src; yarn

ADD . /src/
WORKDIR /src/

ENV NODE_ENV production
RUN yarn build

CMD serve -s build -p 4000
