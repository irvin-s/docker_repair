FROM node:7

MAINTAINER E.G. Galano <eleazar.galano@consensys.net>

EXPOSE 3000

COPY package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /app && cp -a /tmp/node_modules /app/

WORKDIR /app
ADD . /app
RUN npm install
CMD npm start
