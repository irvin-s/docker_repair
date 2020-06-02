FROM node:alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json .

RUN yarn

EXPOSE 8200
CMD ["yarn", "dev"]