FROM node:argon
MAINTAINER Alexandre Masselot <alexandre.masselot@gmail.com>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app
COPY package.json /usr/src/app/
RUN npm install

RUN npm run build
EXPOSE 80

CMD [ "npm", "run", "prod"]


