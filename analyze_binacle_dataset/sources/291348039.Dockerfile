
FROM node:latest

EXPOSE 3000

RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN npm install -g yarn truffle@beta

RUN yarn install 

CMD yarn reset && yarn start

