FROM node:carbon

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV=production
ARG REST_URL=http://localhost:3000
ENV NODE_ENV $NODE_ENV
ENV REST_URL $REST_URL
COPY package.json /usr/src/app/
RUN yarn install && yarn cache clean
COPY . /usr/src/app
RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
