FROM node:9.11.1

RUN mkdir -p /app
COPY package.json /app
COPY yarn.lock /app
WORKDIR /app
RUN yarn

COPY . /app

EXPOSE 8663
ENTRYPOINT yarn start
