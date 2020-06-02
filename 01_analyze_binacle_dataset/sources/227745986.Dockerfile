FROM node:6

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN yarn

COPY . /usr/src/app

RUN yarn build
EXPOSE 3000

CMD [ "yarn", "start" ]
