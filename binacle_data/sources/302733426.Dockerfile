FROM node:carbon

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV
COPY package.json /usr/src/app/
RUN yarn install && yarn cache clean
COPY . /usr/src/app

CMD ["yarn", "start"]
