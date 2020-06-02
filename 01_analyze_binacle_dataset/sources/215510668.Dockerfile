FROM node:10

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm install && npm cache clean --force
COPY . /usr/src/app

EXPOSE 80
CMD [ "npm", "start" ]
