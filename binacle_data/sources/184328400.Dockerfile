FROM node:6.9.1-wheezy

WORKDIR /tmp

RUN apt-get update
RUN apt-get -y install libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install --production

COPY . /usr/src/app

EXPOSE 3000
CMD [ "npm", "start" ]
