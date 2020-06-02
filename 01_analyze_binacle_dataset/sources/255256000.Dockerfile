FROM node:6
MAINTAINER Alwin Arrasyid <alwin.ridd@gmail.com>
WORKDIR /usr/src/reweather
VOLUME /usr/src/reweather
EXPOSE 3000

RUN npm install

CMD ["npm", "start"]
