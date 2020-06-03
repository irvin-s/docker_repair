FROM node:8.7.0
ADD . /app
WORKDIR /app
RUN npm i -g yarn
RUN npm i -g pm2
RUN yarn install
RUN pm2 start /lib/bootstrap.js
EXPOSE 8080
