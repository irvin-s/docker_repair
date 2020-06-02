FROM node:4.3
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
RUN npm install coffee-script -g
COPY src/ /usr/src/app/src
COPY env/ /usr/src/app/env
COPY bin/blurb-server /usr/src/app/bin/
CMD [ "bin/blurb-server", "production" ]

EXPOSE 80
