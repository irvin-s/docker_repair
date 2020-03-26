FROM node:boron

RUN npm install protractor -g
RUN npm install webpack  -g

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app

CMD npm build
